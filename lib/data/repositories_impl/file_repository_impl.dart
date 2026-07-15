import 'dart:io';

import 'package:v_clean_architecture/data/sources/remote/remote.dart';
import 'package:v_clean_architecture/domain/entities/entities.dart';
import 'package:v_clean_architecture/domain/repositories/repositories.dart';

final class FileRepositoryImpl implements FileRepository {
  FileRepositoryImpl({required FileRemoteSource remoteSource})
    : _remoteSource = remoteSource;

  final FileRemoteSource _remoteSource;

  @override
  Future<FileUploadResult> uploadFile({
    required File file,
    String? fileName,
  }) {
    return _remoteSource.uploadFile(
      file: file,
      fileName: fileName,
    );
  }

  @override
  Future<File> downloadFile(
    String url, {
    required String savePath,
    bool shouldEncrypt = true,
    int? downloadedBytes,
    void Function(int received, int total)? onReceiveProgress,
  }) {
    return _remoteSource.downloadFile(
      url,
      savePath: savePath,
      shouldEncrypt: shouldEncrypt,
      downloadedBytes: downloadedBytes,
      onReceiveProgress: onReceiveProgress,
    );
  }

  @override
  Future<AppAssetProperties> getAssetProperties() {
    return _remoteSource.getAssetProperties();
  }
}
