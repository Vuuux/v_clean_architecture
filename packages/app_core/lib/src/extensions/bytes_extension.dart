// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:path_provider/path_provider.dart';

extension BytesExtension on List<int> {
  Future<File> toFile({String extension = 'png'}) async {
    final fileName = DateTime.now().millisecondsSinceEpoch.toString();
    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/$fileName.$extension');
    await file.writeAsBytes(this);
    return file;
  }
}
