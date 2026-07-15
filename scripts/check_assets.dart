/// Utility to detect unused assets in a Flutter project.
///
/// Heuristics:
/// 1. Parses pubspec.yaml for declared asset directories.
/// 2. Collects all files within those directories (recursively).
/// 3. Parses lib/ and packages/*/lib source files for:
///    - Literal string references like 'assets/...'
///    - References via AssetConstants.<name>
/// 4. Maps constants in lib/constants/assets.dart to their paths.
/// 5. Reports assets with no references found.
///
/// Limitations:
/// - Font usage via fontFamily cannot be traced to file path; fonts are marked as used if they appear in assets.dart or are font files.
/// - Dynamic constructions (e.g. using variables to build asset paths) are not detected.
///
/// Options:
///   --json            Output JSON summary.
///   --verbose         Show progress details.
///   --ignore=pattern1,pattern2  Comma separated regex patterns to ignore paths.
///   --fail-on-unused  Exit with code 2 if any unused assets found.
///
/// Usage:
///   dart run scripts/check_assets.dart
///   dart run scripts/check_assets.dart --json --fail-on-unused
import 'dart:convert';
import 'dart:io';

// ANSI color codes for readable terminal output
const _cReset = '\x1B[0m';
const _cRed = '\x1B[31m';
const _cGreen = '\x1B[32m';
const _cYellow = '\x1B[33m';
const _cBlue = '\x1B[34m';
const _cMagenta = '\x1B[35m';
const _cCyan = '\x1B[36m';

void main(List<String> args) async {
  final opts = _parseArgs(args);
  final projectRoot = Directory.current.path;
  final pubspec = File('$projectRoot/pubspec.yaml');
  final assetsConstFile = File('$projectRoot/lib/constants/assets.dart');

  if (!pubspec.existsSync()) {
    stderr.writeln('pubspec.yaml not found');
    exit(1);
  }

  final assetDirs = _extractAssetDirs(pubspec.readAsLinesSync());
  if (assetDirs.isEmpty) {
    stdout.writeln('No asset directories declared in pubspec.yaml');
    exit(0);
  }

  if (opts.verbose) {
    stdout.writeln('Asset directories: ${assetDirs.join(', ')}');
  }

  // Collect all asset files.
  final assetFiles = <String>{};
  for (final dir in assetDirs) {
    final absDir = Directory('$projectRoot/$dir');
    if (!absDir.existsSync()) continue;
    for (final entity in absDir.listSync(recursive: true)) {
      if (entity is File) {
        final rel = entity.path
            .replaceFirst(projectRoot + Platform.pathSeparator, '')
            .replaceAll('\\', '/');
        // Skip hidden and DS_Store etc.
        if (rel.contains('/.') || rel.startsWith('.')) continue;
        assetFiles.add(rel);
      }
    }
  }

  // Always mark font files as used (heuristic) to avoid false positives.
  final fontFiles = assetFiles
      .where((p) => p.startsWith('assets/fonts/') && p.endsWith('.ttf'))
      .toSet();

  // Parse asset constants mapping.
  final constantMap = assetsConstFile.existsSync()
      ? _extractConstants(assetsConstFile.readAsStringSync())
      : <String, String>{};

  // Track constant usage separately.
  final constantUsage = <String, bool>{};
  for (final k in constantMap.keys) {
    constantUsage[k] = false; // initialize
  }

  // Scan source for usages.
  final sourceDirs = <Directory>[];
  final libDir = Directory('$projectRoot/lib');
  if (libDir.existsSync()) sourceDirs.add(libDir);
  final packagesDir = Directory('$projectRoot/packages');
  if (packagesDir.existsSync()) {
    for (final package in packagesDir.listSync()) {
      if (package is Directory) {
        final pkgLib = Directory('${package.path}/lib');
        if (pkgLib.existsSync()) sourceDirs.add(pkgLib);
      }
    }
  }

  final usedAssets = <String>{};
  final assetLiteralRegex = RegExp(r'''['\"](assets/[^'\"\n]+)['\"]''');
  final assetConstRegex = RegExp(r'AssetConstants\.(\w+)');
  final literalAssetsFound = <String>{};
  // Track locations for each literal asset path.
  final literalLocations = <String, List<String>>{};

  for (final dir in sourceDirs) {
    for (final entity in dir.listSync(recursive: true)) {
      if (entity is! File) continue;
      if (!entity.path.endsWith('.dart')) continue;
      final content = entity.readAsStringSync();
      final relFile = entity.path
          .replaceFirst(projectRoot + Platform.pathSeparator, '')
          .replaceAll('\\', '/');
      final lines = content.split('\n');
      for (var i = 0; i < lines.length; i++) {
        final line = lines[i];
        for (final m in assetLiteralRegex.allMatches(line)) {
          final path = m.group(1)!;
          usedAssets.add(path);
          literalAssetsFound.add(path);
          literalLocations.putIfAbsent(path, () => []).add('$relFile:${i + 1}');
        }
      }
      for (final m in assetConstRegex.allMatches(content)) {
        final constName = m.group(1)!;
        final path = constantMap[constName];
        if (path != null) {
          usedAssets.add(path);
          constantUsage[constName] = true;
        }
      }
    }
  }

  // Merge heuristic used font files.
  usedAssets.addAll(fontFiles);

  // Apply ignore patterns.
  final ignorePatterns = opts.ignorePatterns.map((p) => RegExp(p)).toList();
  bool _ignored(String path) => ignorePatterns.any((rx) => rx.hasMatch(path));

  final unused =
      assetFiles.where((a) => !usedAssets.contains(a) && !_ignored(a)).toList()
        ..sort();

  // Derive unused constants (those whose mapped path never referenced).
  final unusedConstants =
      constantUsage.entries
          .where((e) => e.value == false)
          .map((e) => e.key)
          .toList()
        ..sort();

  // Constants pointing to missing files.
  final missingConstantFiles =
      constantMap.entries
          .where((e) => !assetFiles.contains(e.value))
          .map((e) => e.key)
          .toList()
        ..sort();

  // Literal assets that are NOT represented by any AssetConstants value.
  final constantValuesSet = constantMap.values.toSet();
  final literalWithoutConstant =
      literalAssetsFound.where((p) => !constantValuesSet.contains(p)).toList()
        ..sort();

  if (opts.json) {
    final output = {
      'totalAssets': assetFiles.length,
      'usedAssets': usedAssets.length,
      'unusedCount': unused.length,
      'unusedAssets': unused,
      'ignoredPatterns': opts.ignorePatterns,
      'totalConstants': constantMap.length,
      'unusedConstants': unusedConstants,
      'missingConstantFiles': missingConstantFiles,
      'literalAssetsFound': literalAssetsFound.toList()..sort(),
      'literalWithoutConstant': literalWithoutConstant,
      'literalLocations': literalLocations.map((k, v) => MapEntry(k, v)),
    };
    stdout.writeln(jsonEncode(output));
  } else if (opts.simple) {
    stdout.writeln('${_cBlue}Simplified Asset Usage Report${_cReset}');
    stdout.writeln('Project root: $projectRoot');
    stdout.writeln('Total asset files: ${assetFiles.length}');
    stdout.writeln('Literal assets (unique): ${literalAssetsFound.length}');
    final uncovered = literalWithoutConstant;
    stdout.writeln(
      '\n${_cYellow}Literal assets NOT covered by AssetConstants (${uncovered.length}):${_cReset}',
    );
    for (final path in uncovered) {
      stdout.writeln('  $path');
      final locs = literalLocations[path] ?? const [];
      for (final l in locs) {
        stdout.writeln('    - $l');
      }
    }
    if (uncovered.isEmpty) {
      stdout.writeln('  (None)');
    }
    if (!opts.onlyLiteral) {
      stdout.writeln('\n${_cRed}Unused assets (${unused.length}):${_cReset}');
      for (final u in unused) {
        stdout.writeln('  $u');
      }
      if (unused.isEmpty) stdout.writeln('  (None)');
    }
    stdout.writeln(
      '\nTip: Add missing constants in lib/constants/assets.dart to standardize usage.',
    );
  } else {
    stdout.writeln('${_cBlue}Total assets:${_cReset} ${assetFiles.length}');
    stdout.writeln(
      '${_cGreen}Used assets (heuristic):${_cReset} ${usedAssets.length}',
    );
    stdout.writeln('${_cRed}Unused assets:${_cReset} ${unused.length}');
    if (unused.isNotEmpty) {
      stdout.writeln('\n${_cRed}Unused asset paths:${_cReset}');
      for (final u in unused) {
        stdout.writeln('  $u');
      }
    }
    stdout.writeln('\n${_cMagenta}AssetConstants summary:${_cReset}');
    stdout.writeln('  Total constants: ${constantMap.length}');
    stdout.writeln('  Unused constants: ${unusedConstants.length}');
    if (unusedConstants.isNotEmpty) {
      stdout.writeln('  ${_cYellow}Unused constants detail:${_cReset}');
      for (final c in unusedConstants) {
        final p = constantMap[c];
        final missing = missingConstantFiles.contains(c)
            ? ' (${_cRed}MISSING FILE${_cReset})'
            : '';
        stdout.writeln('    $c => $p$missing');
      }
    }
    if (missingConstantFiles.isNotEmpty) {
      stdout.writeln(
        '\n${_cRed}Constants referencing missing files:${_cReset}',
      );
      for (final c in missingConstantFiles) {
        stdout.writeln('  $c => ${constantMap[c]}');
      }
    }
    stdout.writeln(
      '\n${_cCyan}Raw literal asset paths found (unique):${_cReset} ${literalAssetsFound.length}',
    );
    if (literalAssetsFound.isNotEmpty) {
      stdout.writeln('  Example first 10:');
      for (final p in literalAssetsFound.take(10)) {
        stdout.writeln('    $p');
      }
    }
    stdout.writeln(
      '${_cYellow}Literal assets not covered by AssetConstants:${_cReset} ${literalWithoutConstant.length}',
    );
    if (literalWithoutConstant.isNotEmpty) {
      stdout.writeln('  Consider adding constants for:');
      for (final p in literalWithoutConstant.take(20)) {
        stdout.writeln('    $p');
      }
      if (literalWithoutConstant.length > 20) {
        stdout.writeln('    ... (${literalWithoutConstant.length - 20} more)');
      }
    }
    if (literalLocations.isNotEmpty) {
      stdout.writeln(
        '\n${_cBlue}Literal asset usage locations (first 5 per asset):${_cReset}',
      );
      final sortedKeys = literalLocations.keys.toList()..sort();
      for (final k in sortedKeys) {
        final locs = literalLocations[k]!;
        // Build display list (first 5 plus summary) without cascade in ternary to avoid parsing issue.
        List<String> display;
        if (locs.length > 5) {
          display = locs.take(5).toList();
          display.add('... (${locs.length - 5} more)');
        } else {
          display = locs;
        }
        stdout.writeln('  $k');
        for (final l in display) {
          stdout.writeln('    - $l');
        }
      }
    }
    if (ignorePatterns.isNotEmpty) {
      stdout.writeln('\nIgnored patterns: ${opts.ignorePatterns.join(', ')}');
    }
  }

  if (unused.isNotEmpty && opts.failOnUnused) {
    exit(2);
  }
}

class _Options {
  final bool json;
  final bool verbose;
  final bool failOnUnused;
  final List<String> ignorePatterns;
  final bool simple;
  final bool onlyLiteral;
  _Options({
    required this.json,
    required this.verbose,
    required this.failOnUnused,
    required this.ignorePatterns,
    required this.simple,
    required this.onlyLiteral,
  });
}

_Options _parseArgs(List<String> args) {
  bool json = false;
  bool verbose = false;
  bool fail = false;
  bool simple = false;
  bool onlyLiteral = false;
  final ignorePatterns = <String>[];
  for (final a in args) {
    if (a == '--json')
      json = true;
    else if (a == '--verbose')
      verbose = true;
    else if (a == '--fail-on-unused')
      fail = true;
    else if (a == '--simple')
      simple = true;
    else if (a == '--only-literal')
      onlyLiteral = true;
    else if (a.startsWith('--ignore=')) {
      final pats = a
          .substring('--ignore='.length)
          .split(',')
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty);
      ignorePatterns.addAll(pats);
    }
  }
  return _Options(
    json: json,
    verbose: verbose,
    failOnUnused: fail,
    ignorePatterns: ignorePatterns,
    simple: simple,
    onlyLiteral: onlyLiteral,
  );
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
        break; // end of assets block
      }
      if (compact.startsWith('- ')) {
        final path = compact.substring(2).trim();
        if (path.isNotEmpty) assetDirs.add(path.replaceAll("'", ''));
      }
    }
  }
  return assetDirs;
}

Map<String, String> _extractConstants(String content) {
  final regex = RegExp(r"static const\s+(\w+)\s*=\s*'([^']+)';");
  final map = <String, String>{};
  for (final m in regex.allMatches(content)) {
    map[m.group(1)!] = m.group(2)!;
  }
  return map;
}
