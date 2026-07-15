import 'package:freezed_annotation/freezed_annotation.dart';

part 'oauth_provider.g.dart';

@JsonEnum(alwaysCreate: true)
enum OAuthProvider {
  @JsonValue('')
  undefined,
  google,
  line,
  apple,
}
