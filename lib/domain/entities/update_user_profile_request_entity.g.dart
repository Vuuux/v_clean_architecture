// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_user_profile_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UpdateUserProfileRequest _$UpdateUserProfileRequestFromJson(
  Map<String, dynamic> json,
) => _UpdateUserProfileRequest(
  dateOfBirth: json['date_of_birth'] as String?,
  gender: $enumDecodeNullable(_$AppUserGenderEnumMap, json['gender']),
  mobileNo: json['mobile_no'] as String?,
  nickname: json['nickname'] as String?,
  nid: json['nid'] as String?,
  personalMessage: json['personal_message'] as String?,
  schoolMtdId: json['school_mtd_id'] as String?,
  firstName: json['first_name'] as String?,
  lastName: json['last_name'] as String?,
  address: json['address'] as String?,
  addressId: json['address_id'] as String?,
);

Map<String, dynamic> _$UpdateUserProfileRequestToJson(
  _UpdateUserProfileRequest instance,
) => <String, dynamic>{
  'date_of_birth': instance.dateOfBirth,
  'gender': _$AppUserGenderEnumMap[instance.gender],
  'mobile_no': instance.mobileNo,
  'nickname': instance.nickname,
  'nid': instance.nid,
  'personal_message': instance.personalMessage,
  'school_mtd_id': instance.schoolMtdId,
  'first_name': instance.firstName,
  'last_name': instance.lastName,
  'address': instance.address,
  'address_id': instance.addressId,
};

const _$AppUserGenderEnumMap = {
  AppUserGender.undefined: '',
  AppUserGender.male: 'male',
  AppUserGender.female: 'female',
  AppUserGender.others: 'others',
};
