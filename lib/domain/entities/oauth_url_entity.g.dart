// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'oauth_url_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_OAuthUrl _$OAuthUrlFromJson(Map<String, dynamic> json) => _OAuthUrl(
  oauthUrl: json['oauth_url'] as String,
  state: json['state'] as String,
);

Map<String, dynamic> _$OAuthUrlToJson(_OAuthUrl instance) => <String, dynamic>{
  'oauth_url': instance.oauthUrl,
  'state': instance.state,
};
