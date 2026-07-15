// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'update_user_profile_request_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UpdateUserProfileRequest {

@JsonKey(name: 'date_of_birth') String? get dateOfBirth; AppUserGender? get gender;@JsonKey(name: 'mobile_no') String? get mobileNo; String? get nickname; String? get nid;@JsonKey(name: 'personal_message') String? get personalMessage;@JsonKey(name: 'school_mtd_id') String? get schoolMtdId;@JsonKey(name: 'first_name') String? get firstName;@JsonKey(name: 'last_name') String? get lastName; String? get address;@JsonKey(name: 'address_id') String? get addressId;
/// Create a copy of UpdateUserProfileRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdateUserProfileRequestCopyWith<UpdateUserProfileRequest> get copyWith => _$UpdateUserProfileRequestCopyWithImpl<UpdateUserProfileRequest>(this as UpdateUserProfileRequest, _$identity);

  /// Serializes this UpdateUserProfileRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateUserProfileRequest&&(identical(other.dateOfBirth, dateOfBirth) || other.dateOfBirth == dateOfBirth)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.mobileNo, mobileNo) || other.mobileNo == mobileNo)&&(identical(other.nickname, nickname) || other.nickname == nickname)&&(identical(other.nid, nid) || other.nid == nid)&&(identical(other.personalMessage, personalMessage) || other.personalMessage == personalMessage)&&(identical(other.schoolMtdId, schoolMtdId) || other.schoolMtdId == schoolMtdId)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.address, address) || other.address == address)&&(identical(other.addressId, addressId) || other.addressId == addressId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,dateOfBirth,gender,mobileNo,nickname,nid,personalMessage,schoolMtdId,firstName,lastName,address,addressId);

@override
String toString() {
  return 'UpdateUserProfileRequest(dateOfBirth: $dateOfBirth, gender: $gender, mobileNo: $mobileNo, nickname: $nickname, nid: $nid, personalMessage: $personalMessage, schoolMtdId: $schoolMtdId, firstName: $firstName, lastName: $lastName, address: $address, addressId: $addressId)';
}


}

/// @nodoc
abstract mixin class $UpdateUserProfileRequestCopyWith<$Res>  {
  factory $UpdateUserProfileRequestCopyWith(UpdateUserProfileRequest value, $Res Function(UpdateUserProfileRequest) _then) = _$UpdateUserProfileRequestCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'date_of_birth') String? dateOfBirth, AppUserGender? gender,@JsonKey(name: 'mobile_no') String? mobileNo, String? nickname, String? nid,@JsonKey(name: 'personal_message') String? personalMessage,@JsonKey(name: 'school_mtd_id') String? schoolMtdId,@JsonKey(name: 'first_name') String? firstName,@JsonKey(name: 'last_name') String? lastName, String? address,@JsonKey(name: 'address_id') String? addressId
});




}
/// @nodoc
class _$UpdateUserProfileRequestCopyWithImpl<$Res>
    implements $UpdateUserProfileRequestCopyWith<$Res> {
  _$UpdateUserProfileRequestCopyWithImpl(this._self, this._then);

  final UpdateUserProfileRequest _self;
  final $Res Function(UpdateUserProfileRequest) _then;

/// Create a copy of UpdateUserProfileRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? dateOfBirth = freezed,Object? gender = freezed,Object? mobileNo = freezed,Object? nickname = freezed,Object? nid = freezed,Object? personalMessage = freezed,Object? schoolMtdId = freezed,Object? firstName = freezed,Object? lastName = freezed,Object? address = freezed,Object? addressId = freezed,}) {
  return _then(_self.copyWith(
dateOfBirth: freezed == dateOfBirth ? _self.dateOfBirth : dateOfBirth // ignore: cast_nullable_to_non_nullable
as String?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as AppUserGender?,mobileNo: freezed == mobileNo ? _self.mobileNo : mobileNo // ignore: cast_nullable_to_non_nullable
as String?,nickname: freezed == nickname ? _self.nickname : nickname // ignore: cast_nullable_to_non_nullable
as String?,nid: freezed == nid ? _self.nid : nid // ignore: cast_nullable_to_non_nullable
as String?,personalMessage: freezed == personalMessage ? _self.personalMessage : personalMessage // ignore: cast_nullable_to_non_nullable
as String?,schoolMtdId: freezed == schoolMtdId ? _self.schoolMtdId : schoolMtdId // ignore: cast_nullable_to_non_nullable
as String?,firstName: freezed == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String?,lastName: freezed == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,addressId: freezed == addressId ? _self.addressId : addressId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [UpdateUserProfileRequest].
extension UpdateUserProfileRequestPatterns on UpdateUserProfileRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UpdateUserProfileRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UpdateUserProfileRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UpdateUserProfileRequest value)  $default,){
final _that = this;
switch (_that) {
case _UpdateUserProfileRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UpdateUserProfileRequest value)?  $default,){
final _that = this;
switch (_that) {
case _UpdateUserProfileRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'date_of_birth')  String? dateOfBirth,  AppUserGender? gender, @JsonKey(name: 'mobile_no')  String? mobileNo,  String? nickname,  String? nid, @JsonKey(name: 'personal_message')  String? personalMessage, @JsonKey(name: 'school_mtd_id')  String? schoolMtdId, @JsonKey(name: 'first_name')  String? firstName, @JsonKey(name: 'last_name')  String? lastName,  String? address, @JsonKey(name: 'address_id')  String? addressId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UpdateUserProfileRequest() when $default != null:
return $default(_that.dateOfBirth,_that.gender,_that.mobileNo,_that.nickname,_that.nid,_that.personalMessage,_that.schoolMtdId,_that.firstName,_that.lastName,_that.address,_that.addressId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'date_of_birth')  String? dateOfBirth,  AppUserGender? gender, @JsonKey(name: 'mobile_no')  String? mobileNo,  String? nickname,  String? nid, @JsonKey(name: 'personal_message')  String? personalMessage, @JsonKey(name: 'school_mtd_id')  String? schoolMtdId, @JsonKey(name: 'first_name')  String? firstName, @JsonKey(name: 'last_name')  String? lastName,  String? address, @JsonKey(name: 'address_id')  String? addressId)  $default,) {final _that = this;
switch (_that) {
case _UpdateUserProfileRequest():
return $default(_that.dateOfBirth,_that.gender,_that.mobileNo,_that.nickname,_that.nid,_that.personalMessage,_that.schoolMtdId,_that.firstName,_that.lastName,_that.address,_that.addressId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'date_of_birth')  String? dateOfBirth,  AppUserGender? gender, @JsonKey(name: 'mobile_no')  String? mobileNo,  String? nickname,  String? nid, @JsonKey(name: 'personal_message')  String? personalMessage, @JsonKey(name: 'school_mtd_id')  String? schoolMtdId, @JsonKey(name: 'first_name')  String? firstName, @JsonKey(name: 'last_name')  String? lastName,  String? address, @JsonKey(name: 'address_id')  String? addressId)?  $default,) {final _that = this;
switch (_that) {
case _UpdateUserProfileRequest() when $default != null:
return $default(_that.dateOfBirth,_that.gender,_that.mobileNo,_that.nickname,_that.nid,_that.personalMessage,_that.schoolMtdId,_that.firstName,_that.lastName,_that.address,_that.addressId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UpdateUserProfileRequest implements UpdateUserProfileRequest {
  const _UpdateUserProfileRequest({@JsonKey(name: 'date_of_birth') this.dateOfBirth, this.gender, @JsonKey(name: 'mobile_no') this.mobileNo, this.nickname, this.nid, @JsonKey(name: 'personal_message') this.personalMessage, @JsonKey(name: 'school_mtd_id') this.schoolMtdId, @JsonKey(name: 'first_name') this.firstName, @JsonKey(name: 'last_name') this.lastName, this.address, @JsonKey(name: 'address_id') this.addressId});
  factory _UpdateUserProfileRequest.fromJson(Map<String, dynamic> json) => _$UpdateUserProfileRequestFromJson(json);

@override@JsonKey(name: 'date_of_birth') final  String? dateOfBirth;
@override final  AppUserGender? gender;
@override@JsonKey(name: 'mobile_no') final  String? mobileNo;
@override final  String? nickname;
@override final  String? nid;
@override@JsonKey(name: 'personal_message') final  String? personalMessage;
@override@JsonKey(name: 'school_mtd_id') final  String? schoolMtdId;
@override@JsonKey(name: 'first_name') final  String? firstName;
@override@JsonKey(name: 'last_name') final  String? lastName;
@override final  String? address;
@override@JsonKey(name: 'address_id') final  String? addressId;

/// Create a copy of UpdateUserProfileRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateUserProfileRequestCopyWith<_UpdateUserProfileRequest> get copyWith => __$UpdateUserProfileRequestCopyWithImpl<_UpdateUserProfileRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UpdateUserProfileRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateUserProfileRequest&&(identical(other.dateOfBirth, dateOfBirth) || other.dateOfBirth == dateOfBirth)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.mobileNo, mobileNo) || other.mobileNo == mobileNo)&&(identical(other.nickname, nickname) || other.nickname == nickname)&&(identical(other.nid, nid) || other.nid == nid)&&(identical(other.personalMessage, personalMessage) || other.personalMessage == personalMessage)&&(identical(other.schoolMtdId, schoolMtdId) || other.schoolMtdId == schoolMtdId)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.address, address) || other.address == address)&&(identical(other.addressId, addressId) || other.addressId == addressId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,dateOfBirth,gender,mobileNo,nickname,nid,personalMessage,schoolMtdId,firstName,lastName,address,addressId);

@override
String toString() {
  return 'UpdateUserProfileRequest(dateOfBirth: $dateOfBirth, gender: $gender, mobileNo: $mobileNo, nickname: $nickname, nid: $nid, personalMessage: $personalMessage, schoolMtdId: $schoolMtdId, firstName: $firstName, lastName: $lastName, address: $address, addressId: $addressId)';
}


}

/// @nodoc
abstract mixin class _$UpdateUserProfileRequestCopyWith<$Res> implements $UpdateUserProfileRequestCopyWith<$Res> {
  factory _$UpdateUserProfileRequestCopyWith(_UpdateUserProfileRequest value, $Res Function(_UpdateUserProfileRequest) _then) = __$UpdateUserProfileRequestCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'date_of_birth') String? dateOfBirth, AppUserGender? gender,@JsonKey(name: 'mobile_no') String? mobileNo, String? nickname, String? nid,@JsonKey(name: 'personal_message') String? personalMessage,@JsonKey(name: 'school_mtd_id') String? schoolMtdId,@JsonKey(name: 'first_name') String? firstName,@JsonKey(name: 'last_name') String? lastName, String? address,@JsonKey(name: 'address_id') String? addressId
});




}
/// @nodoc
class __$UpdateUserProfileRequestCopyWithImpl<$Res>
    implements _$UpdateUserProfileRequestCopyWith<$Res> {
  __$UpdateUserProfileRequestCopyWithImpl(this._self, this._then);

  final _UpdateUserProfileRequest _self;
  final $Res Function(_UpdateUserProfileRequest) _then;

/// Create a copy of UpdateUserProfileRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? dateOfBirth = freezed,Object? gender = freezed,Object? mobileNo = freezed,Object? nickname = freezed,Object? nid = freezed,Object? personalMessage = freezed,Object? schoolMtdId = freezed,Object? firstName = freezed,Object? lastName = freezed,Object? address = freezed,Object? addressId = freezed,}) {
  return _then(_UpdateUserProfileRequest(
dateOfBirth: freezed == dateOfBirth ? _self.dateOfBirth : dateOfBirth // ignore: cast_nullable_to_non_nullable
as String?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as AppUserGender?,mobileNo: freezed == mobileNo ? _self.mobileNo : mobileNo // ignore: cast_nullable_to_non_nullable
as String?,nickname: freezed == nickname ? _self.nickname : nickname // ignore: cast_nullable_to_non_nullable
as String?,nid: freezed == nid ? _self.nid : nid // ignore: cast_nullable_to_non_nullable
as String?,personalMessage: freezed == personalMessage ? _self.personalMessage : personalMessage // ignore: cast_nullable_to_non_nullable
as String?,schoolMtdId: freezed == schoolMtdId ? _self.schoolMtdId : schoolMtdId // ignore: cast_nullable_to_non_nullable
as String?,firstName: freezed == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String?,lastName: freezed == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,addressId: freezed == addressId ? _self.addressId : addressId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
