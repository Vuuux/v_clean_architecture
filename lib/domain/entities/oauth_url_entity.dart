import 'package:freezed_annotation/freezed_annotation.dart';

part 'oauth_url_entity.freezed.dart';
part 'oauth_url_entity.g.dart';

@freezed
abstract class OAuthUrl with _$OAuthUrl {
  const factory OAuthUrl({
    @JsonKey(name: 'oauth_url') required String oauthUrl,
    @JsonKey(name: 'state') required String state,
  }) = _OAuthUrl;

  factory OAuthUrl.fromJson(Map<String, dynamic> json) =>
      _$OAuthUrlFromJson(json);
}
