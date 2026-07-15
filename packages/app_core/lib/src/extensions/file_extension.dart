// ignore_for_file: depend_on_referenced_packages

import 'dart:io';
import 'dart:typed_data';
import 'package:encrypt/encrypt.dart';
import 'package:path_provider/path_provider.dart';

extension FileExtension on File {
  Future<String> getRelativePath() async {
    final dirPath = await getApplicationDocumentsDirectory();
    return path.replaceFirst(dirPath.path, '');
  }

  Future<String> getFileExtension() async {
    final relativePath = await getRelativePath();
    final segments = relativePath.split('.');
    if (segments.length > 1) {
      return segments.last.toLowerCase();
    }
    return '';
  }
}

extension FileEncryptionExtension on File {
  static Uint8List generateEncryptionKey({int keyLength = 32}) {
    final key = Key.fromSecureRandom(keyLength);
    return key.bytes;
  }

  Future<File> encryptFile({required Uint8List encryptKey}) async {
    final key = Key(encryptKey);
    final iv = IV.fromSecureRandom(16);
    final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
    final bytes = await readAsBytes();
    final encrypted = encrypter.encryptBytes(bytes, iv: iv);

    final outputFile = File('$path.locked');
    await outputFile.writeAsBytes(iv.bytes + encrypted.bytes);

    await delete();
    return outputFile;
  }

  Future<File> decryptFile(Uint8List encryptKey) async {
    final key = Key(encryptKey);
    final bytes = await readAsBytes();
    final iv = IV(bytes.sublist(0, 16));
    final encryptedData = bytes.sublist(16);

    final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
    final decrypted = encrypter.decryptBytes(Encrypted(encryptedData), iv: iv);

    final tempDir = await getTemporaryDirectory();
    final decryptedFileName = path.split('/').last.replaceAll('.locked', '');
    final decryptedFile = File('${tempDir.path}/$decryptedFileName');
    await decryptedFile.writeAsBytes(decrypted, flush: true);
    return decryptedFile;
  }
}
