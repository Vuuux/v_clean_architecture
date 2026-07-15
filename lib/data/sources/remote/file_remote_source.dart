import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:app_core/app_core.dart';
import 'package:dio/dio.dart';
import 'package:mime/mime.dart';
import 'package:v_clean_architecture/constants/constants.dart';
import 'package:v_clean_architecture/domain/entities/entities.dart';

class _FileApi {
  static const String baseFile = '/v1/files';
  static const String upload = '$baseFile/upload';
  static const String assetProperties = '/media/mobile-asset-properties.json';
}

abstract class FileRemoteSource {
  Future<AppAssetProperties> getAssetProperties();

  Future<FileUploadResult> uploadFile({
    required File file,
    String? fileName,
  });

  Future<File> downloadFile(
    String url, {
    required String savePath,
    bool shouldEncrypt = true,
    int? downloadedBytes,
    void Function(int received, int total)? onReceiveProgress,
  });
}

final class FileRemoteSourceImpl implements FileRemoteSource {
  FileRemoteSourceImpl({
    required BaseHttpClient client,
    required LocalStorage localStorage,
  }) : _client = client,
       _localStorage = localStorage;

  final BaseHttpClient _client;
  final LocalStorage _localStorage;

  Future<Uint8List> _getEncryptionKey() async {
    final key = await _localStorage.getString(
      AppLocalStorageKey.fileEncryptionKey,
      shouldDecrypt: true,
    );
    if (key.isEmptyOrNull) {
      final newKey = FileEncryptionExtension.generateEncryptionKey();
      await _localStorage.setString(
        AppLocalStorageKey.fileEncryptionKey,
        jsonEncode(newKey),
        shouldEncrypt: true,
      );
      return newKey;
    }

    return Uint8List.fromList(List<int>.from(jsonDecode(key!) as List));
  }

  @override
  Future<FileUploadResult> uploadFile({
    required File file,
    String? fileName,
  }) async {
    final mimeTypes = lookupMimeType(file.path)!.split('/');
    final formData = FormData.fromMap({
      'files': await MultipartFile.fromFile(
        file.path,
        filename: fileName ?? file.path.split('/').last,
        contentType: DioMediaType(mimeTypes[0], mimeTypes[1]),
      ),
    });

    final response = await _client.post(
      _FileApi.upload,
      headers: {
        HttpConstants.contentType: HttpConstants.multipartFormData,
      },
      body: formData,
    );

    return FileUploadResult.fromJson(response as Map<String, dynamic>);
  }

  @override
  Future<File> downloadFile(
    String url, {
    required String savePath,
    bool shouldEncrypt = true,
    int? downloadedBytes,
    void Function(int received, int total)? onReceiveProgress,
  }) async {
    final tempSavePath = '$savePath.${AppConstants.temporaryDownloadExtension}';
    await _client.download(
      url,
      tempSavePath,
      headers: downloadedBytes != null
          ? {'Range': 'bytes=$downloadedBytes-'}
          : null,
      onReceiveProgress: onReceiveProgress,
    );

    await File(tempSavePath).rename(savePath);
    final downloadedFile = File(savePath);
    if (!shouldEncrypt) return downloadedFile;
    final encryptionKey = await _getEncryptionKey();
    final encryptedFile = await downloadedFile.encryptFile(
      encryptKey: encryptionKey,
    );
    return encryptedFile;
  }

  @override
  Future<AppAssetProperties> getAssetProperties() async {
    final response = await _client.get(_FileApi.assetProperties);
    return AppAssetProperties.fromJson(response as Map<String, dynamic>);
  }
}
