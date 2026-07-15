import 'package:freezed_annotation/freezed_annotation.dart';

part 'deep_link_type.g.dart';

@JsonEnum(alwaysCreate: true)
enum DeepLinkType {
  @JsonValue('single')
  single,
  @JsonValue('batch')
  batch,
}
