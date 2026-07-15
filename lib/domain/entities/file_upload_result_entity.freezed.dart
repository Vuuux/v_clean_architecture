// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'file_upload_result_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FileUploadResult {

@JsonKey(name: 'file_path') String get filePath;
/// Create a copy of FileUploadResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FileUploadResultCopyWith<FileUploadResult> get copyWith => _$FileUploadResultCopyWithImpl<FileUploadResult>(this as FileUploadResult, _$identity);

  /// Serializes this FileUploadResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FileUploadResult&&(identical(other.filePath, filePath) || other.filePath == filePath));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,filePath);

@override
String toString() {
  return 'FileUploadResult(filePath: $filePath)';
}


}

/// @nodoc
abstract mixin class $FileUploadResultCopyWith<$Res>  {
  factory $FileUploadResultCopyWith(FileUploadResult value, $Res Function(FileUploadResult) _then) = _$FileUploadResultCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'file_path') String filePath
});




}
/// @nodoc
class _$FileUploadResultCopyWithImpl<$Res>
    implements $FileUploadResultCopyWith<$Res> {
  _$FileUploadResultCopyWithImpl(this._self, this._then);

  final FileUploadResult _self;
  final $Res Function(FileUploadResult) _then;

/// Create a copy of FileUploadResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? filePath = null,}) {
  return _then(_self.copyWith(
filePath: null == filePath ? _self.filePath : filePath // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [FileUploadResult].
extension FileUploadResultPatterns on FileUploadResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FileUploadResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FileUploadResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FileUploadResult value)  $default,){
final _that = this;
switch (_that) {
case _FileUploadResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FileUploadResult value)?  $default,){
final _that = this;
switch (_that) {
case _FileUploadResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'file_path')  String filePath)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FileUploadResult() when $default != null:
return $default(_that.filePath);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'file_path')  String filePath)  $default,) {final _that = this;
switch (_that) {
case _FileUploadResult():
return $default(_that.filePath);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'file_path')  String filePath)?  $default,) {final _that = this;
switch (_that) {
case _FileUploadResult() when $default != null:
return $default(_that.filePath);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FileUploadResult implements FileUploadResult {
  const _FileUploadResult({@JsonKey(name: 'file_path') required this.filePath});
  factory _FileUploadResult.fromJson(Map<String, dynamic> json) => _$FileUploadResultFromJson(json);

@override@JsonKey(name: 'file_path') final  String filePath;

/// Create a copy of FileUploadResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FileUploadResultCopyWith<_FileUploadResult> get copyWith => __$FileUploadResultCopyWithImpl<_FileUploadResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FileUploadResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FileUploadResult&&(identical(other.filePath, filePath) || other.filePath == filePath));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,filePath);

@override
String toString() {
  return 'FileUploadResult(filePath: $filePath)';
}


}

/// @nodoc
abstract mixin class _$FileUploadResultCopyWith<$Res> implements $FileUploadResultCopyWith<$Res> {
  factory _$FileUploadResultCopyWith(_FileUploadResult value, $Res Function(_FileUploadResult) _then) = __$FileUploadResultCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'file_path') String filePath
});




}
/// @nodoc
class __$FileUploadResultCopyWithImpl<$Res>
    implements _$FileUploadResultCopyWith<$Res> {
  __$FileUploadResultCopyWithImpl(this._self, this._then);

  final _FileUploadResult _self;
  final $Res Function(_FileUploadResult) _then;

/// Create a copy of FileUploadResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? filePath = null,}) {
  return _then(_FileUploadResult(
filePath: null == filePath ? _self.filePath : filePath // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
