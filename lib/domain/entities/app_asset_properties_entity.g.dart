// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_asset_properties_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AppAssetProperties _$AppAssetPropertiesFromJson(Map<String, dynamic> json) =>
    _AppAssetProperties(
      images: AppAssetImageProperties.fromJson(
        json['images'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$AppAssetPropertiesToJson(_AppAssetProperties instance) =>
    <String, dynamic>{'images': instance.images};

_AppAssetImageProperties _$AppAssetImagePropertiesFromJson(
  Map<String, dynamic> json,
) => _AppAssetImageProperties(
  list1xImages:
      (json['1x'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  list2xImages:
      (json['2x'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  list3xImages:
      (json['3x'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
);

Map<String, dynamic> _$AppAssetImagePropertiesToJson(
  _AppAssetImageProperties instance,
) => <String, dynamic>{
  '1x': instance.list1xImages,
  '2x': instance.list2xImages,
  '3x': instance.list3xImages,
};
