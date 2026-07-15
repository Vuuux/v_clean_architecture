// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_user_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AppUser {

@JsonKey(name: 'user_id') String get userId; String get id; String get username; String? get avatar; String? get email; String? get address; AppUserGender? get gender; String? get nickname; String? get org; String? get nid; String? get code; AppUserStage? get stage; AppUserStatus? get status;@JsonKey(name: 'address_id') String? get addressId;@JsonKey(name: 'cover_photo') String? get coverPhoto;@JsonKey(name: 'created_at') String? get createdAt;@JsonKey(name: 'updated_at') String? get updatedAt;@JsonKey(name: 'date_of_birth') String? get dateOfBirth;@JsonKey(name: 'en_first_name') String? get enFirstName;@JsonKey(name: 'en_last_name') String? get enLastName;@JsonKey(name: 'mobile_no') String? get mobileNo;@JsonKey(name: 'is_following') bool? get isFollowing;
/// Create a copy of AppUser
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppUserCopyWith<AppUser> get copyWith => _$AppUserCopyWithImpl<AppUser>(this as AppUser, _$identity);

  /// Serializes this AppUser to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppUser&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.id, id) || other.id == id)&&(identical(other.username, username) || other.username == username)&&(identical(other.avatar, avatar) || other.avatar == avatar)&&(identical(other.email, email) || other.email == email)&&(identical(other.address, address) || other.address == address)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.nickname, nickname) || other.nickname == nickname)&&(identical(other.org, org) || other.org == org)&&(identical(other.nid, nid) || other.nid == nid)&&(identical(other.code, code) || other.code == code)&&(identical(other.stage, stage) || other.stage == stage)&&(identical(other.status, status) || other.status == status)&&(identical(other.addressId, addressId) || other.addressId == addressId)&&(identical(other.coverPhoto, coverPhoto) || other.coverPhoto == coverPhoto)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.dateOfBirth, dateOfBirth) || other.dateOfBirth == dateOfBirth)&&(identical(other.enFirstName, enFirstName) || other.enFirstName == enFirstName)&&(identical(other.enLastName, enLastName) || other.enLastName == enLastName)&&(identical(other.mobileNo, mobileNo) || other.mobileNo == mobileNo)&&(identical(other.isFollowing, isFollowing) || other.isFollowing == isFollowing));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,userId,id,username,avatar,email,address,gender,nickname,org,nid,code,stage,status,addressId,coverPhoto,createdAt,updatedAt,dateOfBirth,enFirstName,enLastName,mobileNo,isFollowing]);

@override
String toString() {
  return 'AppUser(userId: $userId, id: $id, username: $username, avatar: $avatar, email: $email, address: $address, gender: $gender, nickname: $nickname, org: $org, nid: $nid, code: $code, stage: $stage, status: $status, addressId: $addressId, coverPhoto: $coverPhoto, createdAt: $createdAt, updatedAt: $updatedAt, dateOfBirth: $dateOfBirth, enFirstName: $enFirstName, enLastName: $enLastName, mobileNo: $mobileNo, isFollowing: $isFollowing)';
}


}

/// @nodoc
abstract mixin class $AppUserCopyWith<$Res>  {
  factory $AppUserCopyWith(AppUser value, $Res Function(AppUser) _then) = _$AppUserCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'user_id') String userId, String id, String username, String? avatar, String? email, String? address, AppUserGender? gender, String? nickname, String? org, String? nid, String? code, AppUserStage? stage, AppUserStatus? status,@JsonKey(name: 'address_id') String? addressId,@JsonKey(name: 'cover_photo') String? coverPhoto,@JsonKey(name: 'created_at') String? createdAt,@JsonKey(name: 'updated_at') String? updatedAt,@JsonKey(name: 'date_of_birth') String? dateOfBirth,@JsonKey(name: 'en_first_name') String? enFirstName,@JsonKey(name: 'en_last_name') String? enLastName,@JsonKey(name: 'mobile_no') String? mobileNo,@JsonKey(name: 'is_following') bool? isFollowing
});




}
/// @nodoc
class _$AppUserCopyWithImpl<$Res>
    implements $AppUserCopyWith<$Res> {
  _$AppUserCopyWithImpl(this._self, this._then);

  final AppUser _self;
  final $Res Function(AppUser) _then;

/// Create a copy of AppUser
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? id = null,Object? username = null,Object? avatar = freezed,Object? email = freezed,Object? address = freezed,Object? gender = freezed,Object? nickname = freezed,Object? org = freezed,Object? nid = freezed,Object? code = freezed,Object? stage = freezed,Object? status = freezed,Object? addressId = freezed,Object? coverPhoto = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? dateOfBirth = freezed,Object? enFirstName = freezed,Object? enLastName = freezed,Object? mobileNo = freezed,Object? isFollowing = freezed,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,avatar: freezed == avatar ? _self.avatar : avatar // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as AppUserGender?,nickname: freezed == nickname ? _self.nickname : nickname // ignore: cast_nullable_to_non_nullable
as String?,org: freezed == org ? _self.org : org // ignore: cast_nullable_to_non_nullable
as String?,nid: freezed == nid ? _self.nid : nid // ignore: cast_nullable_to_non_nullable
as String?,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,stage: freezed == stage ? _self.stage : stage // ignore: cast_nullable_to_non_nullable
as AppUserStage?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as AppUserStatus?,addressId: freezed == addressId ? _self.addressId : addressId // ignore: cast_nullable_to_non_nullable
as String?,coverPhoto: freezed == coverPhoto ? _self.coverPhoto : coverPhoto // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String?,dateOfBirth: freezed == dateOfBirth ? _self.dateOfBirth : dateOfBirth // ignore: cast_nullable_to_non_nullable
as String?,enFirstName: freezed == enFirstName ? _self.enFirstName : enFirstName // ignore: cast_nullable_to_non_nullable
as String?,enLastName: freezed == enLastName ? _self.enLastName : enLastName // ignore: cast_nullable_to_non_nullable
as String?,mobileNo: freezed == mobileNo ? _self.mobileNo : mobileNo // ignore: cast_nullable_to_non_nullable
as String?,isFollowing: freezed == isFollowing ? _self.isFollowing : isFollowing // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [AppUser].
extension AppUserPatterns on AppUser {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppUser value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppUser() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppUser value)  $default,){
final _that = this;
switch (_that) {
case _AppUser():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppUser value)?  $default,){
final _that = this;
switch (_that) {
case _AppUser() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'user_id')  String userId,  String id,  String username,  String? avatar,  String? email,  String? address,  AppUserGender? gender,  String? nickname,  String? org,  String? nid,  String? code,  AppUserStage? stage,  AppUserStatus? status, @JsonKey(name: 'address_id')  String? addressId, @JsonKey(name: 'cover_photo')  String? coverPhoto, @JsonKey(name: 'created_at')  String? createdAt, @JsonKey(name: 'updated_at')  String? updatedAt, @JsonKey(name: 'date_of_birth')  String? dateOfBirth, @JsonKey(name: 'en_first_name')  String? enFirstName, @JsonKey(name: 'en_last_name')  String? enLastName, @JsonKey(name: 'mobile_no')  String? mobileNo, @JsonKey(name: 'is_following')  bool? isFollowing)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppUser() when $default != null:
return $default(_that.userId,_that.id,_that.username,_that.avatar,_that.email,_that.address,_that.gender,_that.nickname,_that.org,_that.nid,_that.code,_that.stage,_that.status,_that.addressId,_that.coverPhoto,_that.createdAt,_that.updatedAt,_that.dateOfBirth,_that.enFirstName,_that.enLastName,_that.mobileNo,_that.isFollowing);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'user_id')  String userId,  String id,  String username,  String? avatar,  String? email,  String? address,  AppUserGender? gender,  String? nickname,  String? org,  String? nid,  String? code,  AppUserStage? stage,  AppUserStatus? status, @JsonKey(name: 'address_id')  String? addressId, @JsonKey(name: 'cover_photo')  String? coverPhoto, @JsonKey(name: 'created_at')  String? createdAt, @JsonKey(name: 'updated_at')  String? updatedAt, @JsonKey(name: 'date_of_birth')  String? dateOfBirth, @JsonKey(name: 'en_first_name')  String? enFirstName, @JsonKey(name: 'en_last_name')  String? enLastName, @JsonKey(name: 'mobile_no')  String? mobileNo, @JsonKey(name: 'is_following')  bool? isFollowing)  $default,) {final _that = this;
switch (_that) {
case _AppUser():
return $default(_that.userId,_that.id,_that.username,_that.avatar,_that.email,_that.address,_that.gender,_that.nickname,_that.org,_that.nid,_that.code,_that.stage,_that.status,_that.addressId,_that.coverPhoto,_that.createdAt,_that.updatedAt,_that.dateOfBirth,_that.enFirstName,_that.enLastName,_that.mobileNo,_that.isFollowing);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'user_id')  String userId,  String id,  String username,  String? avatar,  String? email,  String? address,  AppUserGender? gender,  String? nickname,  String? org,  String? nid,  String? code,  AppUserStage? stage,  AppUserStatus? status, @JsonKey(name: 'address_id')  String? addressId, @JsonKey(name: 'cover_photo')  String? coverPhoto, @JsonKey(name: 'created_at')  String? createdAt, @JsonKey(name: 'updated_at')  String? updatedAt, @JsonKey(name: 'date_of_birth')  String? dateOfBirth, @JsonKey(name: 'en_first_name')  String? enFirstName, @JsonKey(name: 'en_last_name')  String? enLastName, @JsonKey(name: 'mobile_no')  String? mobileNo, @JsonKey(name: 'is_following')  bool? isFollowing)?  $default,) {final _that = this;
switch (_that) {
case _AppUser() when $default != null:
return $default(_that.userId,_that.id,_that.username,_that.avatar,_that.email,_that.address,_that.gender,_that.nickname,_that.org,_that.nid,_that.code,_that.stage,_that.status,_that.addressId,_that.coverPhoto,_that.createdAt,_that.updatedAt,_that.dateOfBirth,_that.enFirstName,_that.enLastName,_that.mobileNo,_that.isFollowing);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AppUser implements AppUser {
  const _AppUser({@JsonKey(name: 'user_id') required this.userId, this.id = '', this.username = '', this.avatar, this.email, this.address, this.gender, this.nickname, this.org, this.nid, this.code, this.stage, this.status, @JsonKey(name: 'address_id') this.addressId, @JsonKey(name: 'cover_photo') this.coverPhoto, @JsonKey(name: 'created_at') this.createdAt, @JsonKey(name: 'updated_at') this.updatedAt, @JsonKey(name: 'date_of_birth') this.dateOfBirth, @JsonKey(name: 'en_first_name') this.enFirstName, @JsonKey(name: 'en_last_name') this.enLastName, @JsonKey(name: 'mobile_no') this.mobileNo, @JsonKey(name: 'is_following') this.isFollowing});
  factory _AppUser.fromJson(Map<String, dynamic> json) => _$AppUserFromJson(json);

@override@JsonKey(name: 'user_id') final  String userId;
@override@JsonKey() final  String id;
@override@JsonKey() final  String username;
@override final  String? avatar;
@override final  String? email;
@override final  String? address;
@override final  AppUserGender? gender;
@override final  String? nickname;
@override final  String? org;
@override final  String? nid;
@override final  String? code;
@override final  AppUserStage? stage;
@override final  AppUserStatus? status;
@override@JsonKey(name: 'address_id') final  String? addressId;
@override@JsonKey(name: 'cover_photo') final  String? coverPhoto;
@override@JsonKey(name: 'created_at') final  String? createdAt;
@override@JsonKey(name: 'updated_at') final  String? updatedAt;
@override@JsonKey(name: 'date_of_birth') final  String? dateOfBirth;
@override@JsonKey(name: 'en_first_name') final  String? enFirstName;
@override@JsonKey(name: 'en_last_name') final  String? enLastName;
@override@JsonKey(name: 'mobile_no') final  String? mobileNo;
@override@JsonKey(name: 'is_following') final  bool? isFollowing;

/// Create a copy of AppUser
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppUserCopyWith<_AppUser> get copyWith => __$AppUserCopyWithImpl<_AppUser>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AppUserToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppUser&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.id, id) || other.id == id)&&(identical(other.username, username) || other.username == username)&&(identical(other.avatar, avatar) || other.avatar == avatar)&&(identical(other.email, email) || other.email == email)&&(identical(other.address, address) || other.address == address)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.nickname, nickname) || other.nickname == nickname)&&(identical(other.org, org) || other.org == org)&&(identical(other.nid, nid) || other.nid == nid)&&(identical(other.code, code) || other.code == code)&&(identical(other.stage, stage) || other.stage == stage)&&(identical(other.status, status) || other.status == status)&&(identical(other.addressId, addressId) || other.addressId == addressId)&&(identical(other.coverPhoto, coverPhoto) || other.coverPhoto == coverPhoto)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.dateOfBirth, dateOfBirth) || other.dateOfBirth == dateOfBirth)&&(identical(other.enFirstName, enFirstName) || other.enFirstName == enFirstName)&&(identical(other.enLastName, enLastName) || other.enLastName == enLastName)&&(identical(other.mobileNo, mobileNo) || other.mobileNo == mobileNo)&&(identical(other.isFollowing, isFollowing) || other.isFollowing == isFollowing));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,userId,id,username,avatar,email,address,gender,nickname,org,nid,code,stage,status,addressId,coverPhoto,createdAt,updatedAt,dateOfBirth,enFirstName,enLastName,mobileNo,isFollowing]);

@override
String toString() {
  return 'AppUser(userId: $userId, id: $id, username: $username, avatar: $avatar, email: $email, address: $address, gender: $gender, nickname: $nickname, org: $org, nid: $nid, code: $code, stage: $stage, status: $status, addressId: $addressId, coverPhoto: $coverPhoto, createdAt: $createdAt, updatedAt: $updatedAt, dateOfBirth: $dateOfBirth, enFirstName: $enFirstName, enLastName: $enLastName, mobileNo: $mobileNo, isFollowing: $isFollowing)';
}


}

/// @nodoc
abstract mixin class _$AppUserCopyWith<$Res> implements $AppUserCopyWith<$Res> {
  factory _$AppUserCopyWith(_AppUser value, $Res Function(_AppUser) _then) = __$AppUserCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'user_id') String userId, String id, String username, String? avatar, String? email, String? address, AppUserGender? gender, String? nickname, String? org, String? nid, String? code, AppUserStage? stage, AppUserStatus? status,@JsonKey(name: 'address_id') String? addressId,@JsonKey(name: 'cover_photo') String? coverPhoto,@JsonKey(name: 'created_at') String? createdAt,@JsonKey(name: 'updated_at') String? updatedAt,@JsonKey(name: 'date_of_birth') String? dateOfBirth,@JsonKey(name: 'en_first_name') String? enFirstName,@JsonKey(name: 'en_last_name') String? enLastName,@JsonKey(name: 'mobile_no') String? mobileNo,@JsonKey(name: 'is_following') bool? isFollowing
});




}
/// @nodoc
class __$AppUserCopyWithImpl<$Res>
    implements _$AppUserCopyWith<$Res> {
  __$AppUserCopyWithImpl(this._self, this._then);

  final _AppUser _self;
  final $Res Function(_AppUser) _then;

/// Create a copy of AppUser
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? id = null,Object? username = null,Object? avatar = freezed,Object? email = freezed,Object? address = freezed,Object? gender = freezed,Object? nickname = freezed,Object? org = freezed,Object? nid = freezed,Object? code = freezed,Object? stage = freezed,Object? status = freezed,Object? addressId = freezed,Object? coverPhoto = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? dateOfBirth = freezed,Object? enFirstName = freezed,Object? enLastName = freezed,Object? mobileNo = freezed,Object? isFollowing = freezed,}) {
  return _then(_AppUser(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,avatar: freezed == avatar ? _self.avatar : avatar // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as AppUserGender?,nickname: freezed == nickname ? _self.nickname : nickname // ignore: cast_nullable_to_non_nullable
as String?,org: freezed == org ? _self.org : org // ignore: cast_nullable_to_non_nullable
as String?,nid: freezed == nid ? _self.nid : nid // ignore: cast_nullable_to_non_nullable
as String?,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,stage: freezed == stage ? _self.stage : stage // ignore: cast_nullable_to_non_nullable
as AppUserStage?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as AppUserStatus?,addressId: freezed == addressId ? _self.addressId : addressId // ignore: cast_nullable_to_non_nullable
as String?,coverPhoto: freezed == coverPhoto ? _self.coverPhoto : coverPhoto // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String?,dateOfBirth: freezed == dateOfBirth ? _self.dateOfBirth : dateOfBirth // ignore: cast_nullable_to_non_nullable
as String?,enFirstName: freezed == enFirstName ? _self.enFirstName : enFirstName // ignore: cast_nullable_to_non_nullable
as String?,enLastName: freezed == enLastName ? _self.enLastName : enLastName // ignore: cast_nullable_to_non_nullable
as String?,mobileNo: freezed == mobileNo ? _self.mobileNo : mobileNo // ignore: cast_nullable_to_non_nullable
as String?,isFollowing: freezed == isFollowing ? _self.isFollowing : isFollowing // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}

// dart format on
