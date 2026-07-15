// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_asset_properties_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AppAssetProperties {

@JsonKey(name: 'images') AppAssetImageProperties get images;
/// Create a copy of AppAssetProperties
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppAssetPropertiesCopyWith<AppAssetProperties> get copyWith => _$AppAssetPropertiesCopyWithImpl<AppAssetProperties>(this as AppAssetProperties, _$identity);

  /// Serializes this AppAssetProperties to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppAssetProperties&&(identical(other.images, images) || other.images == images));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,images);

@override
String toString() {
  return 'AppAssetProperties(images: $images)';
}


}

/// @nodoc
abstract mixin class $AppAssetPropertiesCopyWith<$Res>  {
  factory $AppAssetPropertiesCopyWith(AppAssetProperties value, $Res Function(AppAssetProperties) _then) = _$AppAssetPropertiesCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'images') AppAssetImageProperties images
});


$AppAssetImagePropertiesCopyWith<$Res> get images;

}
/// @nodoc
class _$AppAssetPropertiesCopyWithImpl<$Res>
    implements $AppAssetPropertiesCopyWith<$Res> {
  _$AppAssetPropertiesCopyWithImpl(this._self, this._then);

  final AppAssetProperties _self;
  final $Res Function(AppAssetProperties) _then;

/// Create a copy of AppAssetProperties
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? images = null,}) {
  return _then(_self.copyWith(
images: null == images ? _self.images : images // ignore: cast_nullable_to_non_nullable
as AppAssetImageProperties,
  ));
}
/// Create a copy of AppAssetProperties
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AppAssetImagePropertiesCopyWith<$Res> get images {
  
  return $AppAssetImagePropertiesCopyWith<$Res>(_self.images, (value) {
    return _then(_self.copyWith(images: value));
  });
}
}


/// Adds pattern-matching-related methods to [AppAssetProperties].
extension AppAssetPropertiesPatterns on AppAssetProperties {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppAssetProperties value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppAssetProperties() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppAssetProperties value)  $default,){
final _that = this;
switch (_that) {
case _AppAssetProperties():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppAssetProperties value)?  $default,){
final _that = this;
switch (_that) {
case _AppAssetProperties() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'images')  AppAssetImageProperties images)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppAssetProperties() when $default != null:
return $default(_that.images);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'images')  AppAssetImageProperties images)  $default,) {final _that = this;
switch (_that) {
case _AppAssetProperties():
return $default(_that.images);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'images')  AppAssetImageProperties images)?  $default,) {final _that = this;
switch (_that) {
case _AppAssetProperties() when $default != null:
return $default(_that.images);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AppAssetProperties implements AppAssetProperties {
  const _AppAssetProperties({@JsonKey(name: 'images') required this.images});
  factory _AppAssetProperties.fromJson(Map<String, dynamic> json) => _$AppAssetPropertiesFromJson(json);

@override@JsonKey(name: 'images') final  AppAssetImageProperties images;

/// Create a copy of AppAssetProperties
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppAssetPropertiesCopyWith<_AppAssetProperties> get copyWith => __$AppAssetPropertiesCopyWithImpl<_AppAssetProperties>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AppAssetPropertiesToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppAssetProperties&&(identical(other.images, images) || other.images == images));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,images);

@override
String toString() {
  return 'AppAssetProperties(images: $images)';
}


}

/// @nodoc
abstract mixin class _$AppAssetPropertiesCopyWith<$Res> implements $AppAssetPropertiesCopyWith<$Res> {
  factory _$AppAssetPropertiesCopyWith(_AppAssetProperties value, $Res Function(_AppAssetProperties) _then) = __$AppAssetPropertiesCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'images') AppAssetImageProperties images
});


@override $AppAssetImagePropertiesCopyWith<$Res> get images;

}
/// @nodoc
class __$AppAssetPropertiesCopyWithImpl<$Res>
    implements _$AppAssetPropertiesCopyWith<$Res> {
  __$AppAssetPropertiesCopyWithImpl(this._self, this._then);

  final _AppAssetProperties _self;
  final $Res Function(_AppAssetProperties) _then;

/// Create a copy of AppAssetProperties
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? images = null,}) {
  return _then(_AppAssetProperties(
images: null == images ? _self.images : images // ignore: cast_nullable_to_non_nullable
as AppAssetImageProperties,
  ));
}

/// Create a copy of AppAssetProperties
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AppAssetImagePropertiesCopyWith<$Res> get images {
  
  return $AppAssetImagePropertiesCopyWith<$Res>(_self.images, (value) {
    return _then(_self.copyWith(images: value));
  });
}
}


/// @nodoc
mixin _$AppAssetImageProperties {

@JsonKey(name: '1x') List<String> get list1xImages;@JsonKey(name: '2x') List<String> get list2xImages;@JsonKey(name: '3x') List<String> get list3xImages;
/// Create a copy of AppAssetImageProperties
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppAssetImagePropertiesCopyWith<AppAssetImageProperties> get copyWith => _$AppAssetImagePropertiesCopyWithImpl<AppAssetImageProperties>(this as AppAssetImageProperties, _$identity);

  /// Serializes this AppAssetImageProperties to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppAssetImageProperties&&const DeepCollectionEquality().equals(other.list1xImages, list1xImages)&&const DeepCollectionEquality().equals(other.list2xImages, list2xImages)&&const DeepCollectionEquality().equals(other.list3xImages, list3xImages));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(list1xImages),const DeepCollectionEquality().hash(list2xImages),const DeepCollectionEquality().hash(list3xImages));

@override
String toString() {
  return 'AppAssetImageProperties(list1xImages: $list1xImages, list2xImages: $list2xImages, list3xImages: $list3xImages)';
}


}

/// @nodoc
abstract mixin class $AppAssetImagePropertiesCopyWith<$Res>  {
  factory $AppAssetImagePropertiesCopyWith(AppAssetImageProperties value, $Res Function(AppAssetImageProperties) _then) = _$AppAssetImagePropertiesCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: '1x') List<String> list1xImages,@JsonKey(name: '2x') List<String> list2xImages,@JsonKey(name: '3x') List<String> list3xImages
});




}
/// @nodoc
class _$AppAssetImagePropertiesCopyWithImpl<$Res>
    implements $AppAssetImagePropertiesCopyWith<$Res> {
  _$AppAssetImagePropertiesCopyWithImpl(this._self, this._then);

  final AppAssetImageProperties _self;
  final $Res Function(AppAssetImageProperties) _then;

/// Create a copy of AppAssetImageProperties
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? list1xImages = null,Object? list2xImages = null,Object? list3xImages = null,}) {
  return _then(_self.copyWith(
list1xImages: null == list1xImages ? _self.list1xImages : list1xImages // ignore: cast_nullable_to_non_nullable
as List<String>,list2xImages: null == list2xImages ? _self.list2xImages : list2xImages // ignore: cast_nullable_to_non_nullable
as List<String>,list3xImages: null == list3xImages ? _self.list3xImages : list3xImages // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [AppAssetImageProperties].
extension AppAssetImagePropertiesPatterns on AppAssetImageProperties {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppAssetImageProperties value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppAssetImageProperties() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppAssetImageProperties value)  $default,){
final _that = this;
switch (_that) {
case _AppAssetImageProperties():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppAssetImageProperties value)?  $default,){
final _that = this;
switch (_that) {
case _AppAssetImageProperties() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: '1x')  List<String> list1xImages, @JsonKey(name: '2x')  List<String> list2xImages, @JsonKey(name: '3x')  List<String> list3xImages)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppAssetImageProperties() when $default != null:
return $default(_that.list1xImages,_that.list2xImages,_that.list3xImages);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: '1x')  List<String> list1xImages, @JsonKey(name: '2x')  List<String> list2xImages, @JsonKey(name: '3x')  List<String> list3xImages)  $default,) {final _that = this;
switch (_that) {
case _AppAssetImageProperties():
return $default(_that.list1xImages,_that.list2xImages,_that.list3xImages);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: '1x')  List<String> list1xImages, @JsonKey(name: '2x')  List<String> list2xImages, @JsonKey(name: '3x')  List<String> list3xImages)?  $default,) {final _that = this;
switch (_that) {
case _AppAssetImageProperties() when $default != null:
return $default(_that.list1xImages,_that.list2xImages,_that.list3xImages);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AppAssetImageProperties implements AppAssetImageProperties {
  const _AppAssetImageProperties({@JsonKey(name: '1x') final  List<String> list1xImages = const [], @JsonKey(name: '2x') final  List<String> list2xImages = const [], @JsonKey(name: '3x') final  List<String> list3xImages = const []}): _list1xImages = list1xImages,_list2xImages = list2xImages,_list3xImages = list3xImages;
  factory _AppAssetImageProperties.fromJson(Map<String, dynamic> json) => _$AppAssetImagePropertiesFromJson(json);

 final  List<String> _list1xImages;
@override@JsonKey(name: '1x') List<String> get list1xImages {
  if (_list1xImages is EqualUnmodifiableListView) return _list1xImages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_list1xImages);
}

 final  List<String> _list2xImages;
@override@JsonKey(name: '2x') List<String> get list2xImages {
  if (_list2xImages is EqualUnmodifiableListView) return _list2xImages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_list2xImages);
}

 final  List<String> _list3xImages;
@override@JsonKey(name: '3x') List<String> get list3xImages {
  if (_list3xImages is EqualUnmodifiableListView) return _list3xImages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_list3xImages);
}


/// Create a copy of AppAssetImageProperties
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppAssetImagePropertiesCopyWith<_AppAssetImageProperties> get copyWith => __$AppAssetImagePropertiesCopyWithImpl<_AppAssetImageProperties>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AppAssetImagePropertiesToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppAssetImageProperties&&const DeepCollectionEquality().equals(other._list1xImages, _list1xImages)&&const DeepCollectionEquality().equals(other._list2xImages, _list2xImages)&&const DeepCollectionEquality().equals(other._list3xImages, _list3xImages));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_list1xImages),const DeepCollectionEquality().hash(_list2xImages),const DeepCollectionEquality().hash(_list3xImages));

@override
String toString() {
  return 'AppAssetImageProperties(list1xImages: $list1xImages, list2xImages: $list2xImages, list3xImages: $list3xImages)';
}


}

/// @nodoc
abstract mixin class _$AppAssetImagePropertiesCopyWith<$Res> implements $AppAssetImagePropertiesCopyWith<$Res> {
  factory _$AppAssetImagePropertiesCopyWith(_AppAssetImageProperties value, $Res Function(_AppAssetImageProperties) _then) = __$AppAssetImagePropertiesCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: '1x') List<String> list1xImages,@JsonKey(name: '2x') List<String> list2xImages,@JsonKey(name: '3x') List<String> list3xImages
});




}
/// @nodoc
class __$AppAssetImagePropertiesCopyWithImpl<$Res>
    implements _$AppAssetImagePropertiesCopyWith<$Res> {
  __$AppAssetImagePropertiesCopyWithImpl(this._self, this._then);

  final _AppAssetImageProperties _self;
  final $Res Function(_AppAssetImageProperties) _then;

/// Create a copy of AppAssetImageProperties
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? list1xImages = null,Object? list2xImages = null,Object? list3xImages = null,}) {
  return _then(_AppAssetImageProperties(
list1xImages: null == list1xImages ? _self._list1xImages : list1xImages // ignore: cast_nullable_to_non_nullable
as List<String>,list2xImages: null == list2xImages ? _self._list2xImages : list2xImages // ignore: cast_nullable_to_non_nullable
as List<String>,list3xImages: null == list3xImages ? _self._list3xImages : list3xImages // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
