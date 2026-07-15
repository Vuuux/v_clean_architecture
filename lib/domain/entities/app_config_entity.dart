import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_config_entity.freezed.dart';
part 'app_config_entity.g.dart';

@freezed
abstract class AppConfig with _$AppConfig {
  const factory AppConfig({
    required String id,
    required String key,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
    @JsonKey(name: 'updated_by') String? updatedBy,
    String? description,
    String? group,
    List<String>? value,
  }) = _AppConfig;

  factory AppConfig.sample() =>
      AppConfig(id: 'sample', key: 'sample_id', value: []);

  factory AppConfig.fromJson(Map<String, dynamic> json) =>
      _$AppConfigFromJson(json);
}
