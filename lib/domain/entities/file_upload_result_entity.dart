import 'package:freezed_annotation/freezed_annotation.dart';

part 'file_upload_result_entity.freezed.dart';
part 'file_upload_result_entity.g.dart';

@freezed
abstract class FileUploadResult with _$FileUploadResult {
  const factory FileUploadResult({
    @JsonKey(name: 'file_path') required String filePath,
  }) = _FileUploadResult;

  factory FileUploadResult.fromJson(Map<String, dynamic> json) =>
      _$FileUploadResultFromJson(json);
}
