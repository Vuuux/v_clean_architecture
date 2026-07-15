// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_user_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AppUser _$AppUserFromJson(Map<String, dynamic> json) => _AppUser(
  userId: json['user_id'] as String,
  id: json['id'] as String? ?? '',
  username: json['username'] as String? ?? '',
  avatar: json['avatar'] as String?,
  email: json['email'] as String?,
  address: json['address'] as String?,
  gender: $enumDecodeNullable(_$AppUserGenderEnumMap, json['gender']),
  nickname: json['nickname'] as String?,
  org: json['org'] as String?,
  nid: json['nid'] as String?,
  code: json['code'] as String?,
  stage: $enumDecodeNullable(_$AppUserStageEnumMap, json['stage']),
  status: $enumDecodeNullable(_$AppUserStatusEnumMap, json['status']),
  addressId: json['address_id'] as String?,
  coverPhoto: json['cover_photo'] as String?,
  createdAt: json['created_at'] as String?,
  updatedAt: json['updated_at'] as String?,
  dateOfBirth: json['date_of_birth'] as String?,
  enFirstName: json['en_first_name'] as String?,
  enLastName: json['en_last_name'] as String?,
  mobileNo: json['mobile_no'] as String?,
  isFollowing: json['is_following'] as bool?,
);

Map<String, dynamic> _$AppUserToJson(_AppUser instance) => <String, dynamic>{
  'user_id': instance.userId,
  'id': instance.id,
  'username': instance.username,
  'avatar': instance.avatar,
  'email': instance.email,
  'address': instance.address,
  'gender': _$AppUserGenderEnumMap[instance.gender],
  'nickname': instance.nickname,
  'org': instance.org,
  'nid': instance.nid,
  'code': instance.code,
  'stage': _$AppUserStageEnumMap[instance.stage],
  'status': _$AppUserStatusEnumMap[instance.status],
  'address_id': instance.addressId,
  'cover_photo': instance.coverPhoto,
  'created_at': instance.createdAt,
  'updated_at': instance.updatedAt,
  'date_of_birth': instance.dateOfBirth,
  'en_first_name': instance.enFirstName,
  'en_last_name': instance.enLastName,
  'mobile_no': instance.mobileNo,
  'is_following': instance.isFollowing,
};

const _$AppUserGenderEnumMap = {
  AppUserGender.undefined: '',
  AppUserGender.male: 'male',
  AppUserGender.female: 'female',
  AppUserGender.others: 'others',
};

const _$AppUserStageEnumMap = {
  AppUserStage.fresh: 'NEW',
  AppUserStage.otpVerified: 'OTP_VERIFIED',
  AppUserStage.userCreated: 'USER_CREATED',
  AppUserStage.infoUpdated: 'INFO_UPDATED',
  AppUserStage.schoolUpdated: 'SCHOOL_UPDATED',
  AppUserStage.profileUpdated: 'PROFILE_UPDATED',
  AppUserStage.avatarUpdated: 'AVATAR_UPDATED',
  AppUserStage.completed: 'COMPLETED',
};

const _$AppUserStatusEnumMap = {
  AppUserStatus.fresh: 'new',
  AppUserStatus.pending: 'pending',
  AppUserStatus.active: 'active',
  AppUserStatus.inactive: 'inactive',
};
