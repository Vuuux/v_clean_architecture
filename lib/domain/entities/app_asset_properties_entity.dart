import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_asset_properties_entity.freezed.dart';
part 'app_asset_properties_entity.g.dart';

@freezed
abstract class AppAssetProperties with _$AppAssetProperties {
  const factory AppAssetProperties({
    @JsonKey(name: 'images') required AppAssetImageProperties images,
  }) = _AppAssetProperties;

  factory AppAssetProperties.fromJson(Map<String, Object?> json) =>
      _$AppAssetPropertiesFromJson(json);
}

@freezed
abstract class AppAssetImageProperties with _$AppAssetImageProperties {
  const factory AppAssetImageProperties({
    @Default([]) @JsonKey(name: '1x') List<String> list1xImages,
    @Default([]) @JsonKey(name: '2x') List<String> list2xImages,
    @Default([]) @JsonKey(name: '3x') List<String> list3xImages,
  }) = _AppAssetImageProperties;

  factory AppAssetImageProperties.fromJson(Map<String, Object?> json) =>
      _$AppAssetImagePropertiesFromJson(json);
}

extension AppAssetImagesX on AppAssetImageProperties {
  List<String> getListImages(double devicePixelRatio) {
    if (devicePixelRatio.round() >= 3) {
      return list3xImages;
    } else if (devicePixelRatio.round() >= 2) {
      return list2xImages;
    }
    return list1xImages;
  }
}
