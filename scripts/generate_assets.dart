/// Script to scan asset folders defined in pubspec.yaml and append
/// missing entries to lib/constants/assets.dart AssetConstants class.
/// Usage: dart run tool/generate_assets.dart
import 'dart:io';

void main() async {
  final projectRoot = Directory.current.path;
  final pubspecFile = File('$projectRoot/pubspec.yaml');
  final assetsConstFile = File('$projectRoot/lib/constants/assets.dart');

  if (!pubspecFile.existsSync()) {
    stderr.writeln('pubspec.yaml not found');
    exit(1);
  }
  if (!assetsConstFile.existsSync()) {
    stderr.writeln('assets.dart not found at lib/constants/assets.dart');
    exit(1);
  }

  final assetDirs = _extractAssetDirs(pubspecFile.readAsLinesSync());
  if (assetDirs.isEmpty) {
    stdout.writeln('No asset directories found in pubspec.yaml');
    return;
  }

  stdout.writeln('Found asset directories:');
  assetDirs.forEach(stdout.writeln);

  final assetPaths = <String>{};
  for (final dir in assetDirs) {
    final absoluteDir = Directory('$projectRoot/$dir');
    if (!absoluteDir.existsSync()) continue;
    for (final entity in absoluteDir.listSync(recursive: true)) {
      if (entity is File) {
        final relPath = entity.path.replaceFirst(
          projectRoot + Platform.pathSeparator,
          '',
        );
        // Normalize to forward slashes for Flutter asset usage.
        final normalized = relPath.replaceAll(r'\\', '/');
        // Skip hidden files / metadata
        if (normalized.startsWith('.') || normalized.contains('/.')) continue;
        // Skip resolution-specific image variants (2.0x, 3.0x)
        if (normalized.contains('/2.0x/') || normalized.contains('/3.0x/')) {
          continue;
        }
        assetPaths.add(normalized);
      }
    }
  }

  stdout.writeln('Total asset files discovered: ${assetPaths.length}');

  // Parse existing constants.
  final existingContent = assetsConstFile.readAsStringSync();
  final existingConstants = _extractExistingConstants(existingContent);
  stdout.writeln('Existing constants: ${existingConstants.length}');

  // Build set of existing asset paths found on disk.
  final existingAssetPaths = assetPaths;

  // Determine constants referencing removed / non-existent assets and duplicates.
  final removedConstants = <String>{};
  final seenPaths = <String>{};
  existingConstants.forEach((constName, assetPath) {
    final exists = existingAssetPaths.contains(assetPath);
    final isDuplicate = !seenPaths.add(assetPath); // second time path appears
    if ((!exists && !assetPath.startsWith(r'media/images/')) || isDuplicate) {
      removedConstants.add(constName);
    }
  });

  if (removedConstants.isNotEmpty) {
    stdout.writeln(
      'Removing ${removedConstants.length} stale or duplicate constants',
    );
  }

  final cleanedContent = _removeStaleAndGeneratedBlocks(
    existingContent,
    removedConstants,
  );

  final cleanedConstants = _extractExistingConstants(cleanedContent);

  final toGenerate =
      assetPaths.where((p) => !cleanedConstants.containsValue(p)).toList()
        ..sort();

  if (toGenerate.isEmpty) {
    stdout.writeln('No new assets to add. Updating removals only.');
    assetsConstFile.writeAsStringSync(cleanedContent);
    return;
  }

  stdout.writeln('Adding ${toGenerate.length} new asset constants');

  // Generate constant lines.
  final usedNames = cleanedConstants.keys.toSet();
  final generatedLines = <String>[];
  for (final path in toGenerate) {
    final name = _generateConstantName(path, usedNames);
    generatedLines.add("  static const $name = '$path';");
  }

  final updated = _appendGeneratedBlock(cleanedContent, generatedLines);
  assetsConstFile.writeAsStringSync(updated);
  stdout.writeln('Asset constants synchronization complete.');
}

List<String> _extractAssetDirs(List<String> lines) {
  final assetDirs = <String>[];
  var inFlutter = false;
  var inAssets = false;
  for (final raw in lines) {
    final compact = raw.trim();

    if (compact.startsWith('flutter:')) {
      inFlutter = true;
      inAssets = false;
      continue;
    }
    if (inFlutter && compact.startsWith('assets:')) {
      inAssets = true;
      continue;
    }

    if (inFlutter && inAssets) {
      if (compact.isNotEmpty &&
          !compact.startsWith('- ') &&
          !compact.startsWith('#') &&
          !raw.startsWith('  ') &&
          !raw.startsWith('    -')) {
        break;
      }
      if (compact.startsWith('- ')) {
        final path = compact.substring(2).trim();
        if (path.isNotEmpty) {
          assetDirs.add(path.replaceAll("'", ''));
        }
      }
    }
  }
  return assetDirs;
}

Map<String, String> _extractExistingConstants(String content) {
  final regex = RegExp(r"static const\s+(\w+)\s*=\s*\'(.*?)\';");
  final map = <String, String>{};
  for (final m in regex.allMatches(content)) {
    map[m.group(1)!] = m.group(2)!;
  }
  return map;
}

String _generateConstantName(String assetPath, Set<String> usedNames) {
  final fileName = assetPath.split('/').last;
  final base = fileName.split('.').first;
  final candidate = _normalizeBase(base);
  // Ensure uniqueness
  var unique = candidate;
  var i = 2;
  while (usedNames.contains(unique)) {
    unique = '$candidate$i';
    i++;
  }
  usedNames.add(unique);
  return unique;
}

String _normalizeBase(String base) {
  final parts = base
      .split(RegExp(r'[_\-]'))
      .where((p) => p.isNotEmpty)
      .toList();
  if (parts.isEmpty) return base;
  if (parts.length == 1) {
    final single = parts.first;
    return single[0].toLowerCase() + single.substring(1);
  }
  final buffer = StringBuffer()..write(parts.first.toLowerCase());
  for (var i = 1; i < parts.length; i++) {
    final segment = parts[i].toLowerCase();
    buffer.write(segment[0].toUpperCase());
    if (segment.length > 1) buffer.write(segment.substring(1));
  }
  return buffer.toString();
}

String _removeStaleAndGeneratedBlocks(String original, Set<String> staleNames) {
  final lines = original.split('\n');
  final stalePattern = RegExp(r'static const\s+(\w+)\s*=');
  const generatedMarker = '// Auto-generated below. Do not modify manually.';
  final buffer = StringBuffer();
  var skippingGenerated = false;
  for (final line in lines) {
    if (line.trim() == generatedMarker) {
      skippingGenerated = true; // start skipping old generated block
      continue;
    }
    if (skippingGenerated) {
      if (line.trim() == '}' || line.contains('class AssetConstants')) {
        skippingGenerated = false;
        if (line.trim() == '}') {
          buffer.writeln(line); // keep closing brace
        }
        continue;
      }
      // Continue skipping lines of old generated block
      continue;
    }
    final match = stalePattern.firstMatch(line);
    if (match != null) {
      final name = match.group(1)!;
      if (staleNames.contains(name)) {
        // Skip stale constant
        continue;
      }
    }
    buffer.writeln(line);
  }
  return buffer.toString();
}

String _appendGeneratedBlock(String cleaned, List<String> lines) {
  final closingIndex = cleaned.lastIndexOf('}');
  if (closingIndex == -1) {
    throw StateError('Could not find closing brace for AssetConstants');
  }
  final insertion = StringBuffer()
    ..writeln('// Auto-generated below. Do not modify manually.');
  for (final l in lines) {
    insertion.writeln(l);
  }
  return '${cleaned.substring(0, closingIndex)}$insertion\n${cleaned.substring(closingIndex)}';
}
