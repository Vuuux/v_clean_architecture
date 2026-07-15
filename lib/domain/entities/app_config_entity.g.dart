// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_config_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AppConfig _$AppConfigFromJson(Map<String, dynamic> json) => _AppConfig(
  id: json['id'] as String,
  key: json['key'] as String,
  createdAt: json['created_at'] as String?,
  updatedAt: json['updated_at'] as String?,
  updatedBy: json['updated_by'] as String?,
  description: json['description'] as String?,
  group: json['group'] as String?,
  value: (json['value'] as List<dynamic>?)?.map((e) => e as String).toList(),
);

Map<String, dynamic> _$AppConfigToJson(_AppConfig instance) =>
    <String, dynamic>{
      'id': instance.id,
      'key': instance.key,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'updated_by': instance.updatedBy,
      'description': instance.description,
      'group': instance.group,
      'value': instance.value,
    };
