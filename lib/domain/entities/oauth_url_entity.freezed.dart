// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'oauth_url_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OAuthUrl {

@JsonKey(name: 'oauth_url') String get oauthUrl;@JsonKey(name: 'state') String get state;
/// Create a copy of OAuthUrl
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OAuthUrlCopyWith<OAuthUrl> get copyWith => _$OAuthUrlCopyWithImpl<OAuthUrl>(this as OAuthUrl, _$identity);

  /// Serializes this OAuthUrl to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OAuthUrl&&(identical(other.oauthUrl, oauthUrl) || other.oauthUrl == oauthUrl)&&(identical(other.state, state) || other.state == state));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,oauthUrl,state);

@override
String toString() {
  return 'OAuthUrl(oauthUrl: $oauthUrl, state: $state)';
}


}

/// @nodoc
abstract mixin class $OAuthUrlCopyWith<$Res>  {
  factory $OAuthUrlCopyWith(OAuthUrl value, $Res Function(OAuthUrl) _then) = _$OAuthUrlCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'oauth_url') String oauthUrl,@JsonKey(name: 'state') String state
});




}
/// @nodoc
class _$OAuthUrlCopyWithImpl<$Res>
    implements $OAuthUrlCopyWith<$Res> {
  _$OAuthUrlCopyWithImpl(this._self, this._then);

  final OAuthUrl _self;
  final $Res Function(OAuthUrl) _then;

/// Create a copy of OAuthUrl
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? oauthUrl = null,Object? state = null,}) {
  return _then(_self.copyWith(
oauthUrl: null == oauthUrl ? _self.oauthUrl : oauthUrl // ignore: cast_nullable_to_non_nullable
as String,state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [OAuthUrl].
extension OAuthUrlPatterns on OAuthUrl {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OAuthUrl value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OAuthUrl() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OAuthUrl value)  $default,){
final _that = this;
switch (_that) {
case _OAuthUrl():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OAuthUrl value)?  $default,){
final _that = this;
switch (_that) {
case _OAuthUrl() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'oauth_url')  String oauthUrl, @JsonKey(name: 'state')  String state)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OAuthUrl() when $default != null:
return $default(_that.oauthUrl,_that.state);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'oauth_url')  String oauthUrl, @JsonKey(name: 'state')  String state)  $default,) {final _that = this;
switch (_that) {
case _OAuthUrl():
return $default(_that.oauthUrl,_that.state);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'oauth_url')  String oauthUrl, @JsonKey(name: 'state')  String state)?  $default,) {final _that = this;
switch (_that) {
case _OAuthUrl() when $default != null:
return $default(_that.oauthUrl,_that.state);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OAuthUrl implements OAuthUrl {
  const _OAuthUrl({@JsonKey(name: 'oauth_url') required this.oauthUrl, @JsonKey(name: 'state') required this.state});
  factory _OAuthUrl.fromJson(Map<String, dynamic> json) => _$OAuthUrlFromJson(json);

@override@JsonKey(name: 'oauth_url') final  String oauthUrl;
@override@JsonKey(name: 'state') final  String state;

/// Create a copy of OAuthUrl
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OAuthUrlCopyWith<_OAuthUrl> get copyWith => __$OAuthUrlCopyWithImpl<_OAuthUrl>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OAuthUrlToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OAuthUrl&&(identical(other.oauthUrl, oauthUrl) || other.oauthUrl == oauthUrl)&&(identical(other.state, state) || other.state == state));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,oauthUrl,state);

@override
String toString() {
  return 'OAuthUrl(oauthUrl: $oauthUrl, state: $state)';
}


}

/// @nodoc
abstract mixin class _$OAuthUrlCopyWith<$Res> implements $OAuthUrlCopyWith<$Res> {
  factory _$OAuthUrlCopyWith(_OAuthUrl value, $Res Function(_OAuthUrl) _then) = __$OAuthUrlCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'oauth_url') String oauthUrl,@JsonKey(name: 'state') String state
});




}
/// @nodoc
class __$OAuthUrlCopyWithImpl<$Res>
    implements _$OAuthUrlCopyWith<$Res> {
  __$OAuthUrlCopyWithImpl(this._self, this._then);

  final _OAuthUrl _self;
  final $Res Function(_OAuthUrl) _then;

/// Create a copy of OAuthUrl
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? oauthUrl = null,Object? state = null,}) {
  return _then(_OAuthUrl(
oauthUrl: null == oauthUrl ? _self.oauthUrl : oauthUrl // ignore: cast_nullable_to_non_nullable
as String,state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
