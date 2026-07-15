// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_result_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AuthResult _$AuthResultFromJson(Map<String, dynamic> json) => _AuthResult(
  status:
      $enumDecodeNullable(_$AppUserStatusEnumMap, json['status']) ??
      AppUserStatus.fresh,
  onboardingToken: json['onboarding_token'] as String?,
  accessToken: json['access_token'] as String?,
  refreshToken: json['refresh_token'] as String?,
  isRegister: json['is_register'] as bool? ?? false,
);

Map<String, dynamic> _$AuthResultToJson(_AuthResult instance) =>
    <String, dynamic>{
      'status': _$AppUserStatusEnumMap[instance.status]!,
      'onboarding_token': instance.onboardingToken,
      'access_token': instance.accessToken,
      'refresh_token': instance.refreshToken,
      'is_register': instance.isRegister,
    };

const _$AppUserStatusEnumMap = {
  AppUserStatus.fresh: 'new',
  AppUserStatus.pending: 'pending',
  AppUserStatus.active: 'active',
  AppUserStatus.inactive: 'inactive',
};
