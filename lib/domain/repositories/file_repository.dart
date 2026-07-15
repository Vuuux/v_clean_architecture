import 'dart:io';

import 'package:v_clean_architecture/domain/entities/entities.dart';

abstract class FileRepository {
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
