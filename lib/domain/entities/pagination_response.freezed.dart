// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pagination_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PaginationResponse<T> {

 List<T> get data; int get page; int get total;@JsonKey(name: 'total_pages') int get totalPages;
/// Create a copy of PaginationResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaginationResponseCopyWith<T, PaginationResponse<T>> get copyWith => _$PaginationResponseCopyWithImpl<T, PaginationResponse<T>>(this as PaginationResponse<T>, _$identity);

  /// Serializes this PaginationResponse to a JSON map.
  Map<String, dynamic> toJson(Object? Function(T) toJsonT);


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaginationResponse<T>&&const DeepCollectionEquality().equals(other.data, data)&&(identical(other.page, page) || other.page == page)&&(identical(other.total, total) || other.total == total)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(data),page,total,totalPages);

@override
String toString() {
  return 'PaginationResponse<$T>(data: $data, page: $page, total: $total, totalPages: $totalPages)';
}


}

/// @nodoc
abstract mixin class $PaginationResponseCopyWith<T,$Res>  {
  factory $PaginationResponseCopyWith(PaginationResponse<T> value, $Res Function(PaginationResponse<T>) _then) = _$PaginationResponseCopyWithImpl;
@useResult
$Res call({
 List<T> data, int page, int total,@JsonKey(name: 'total_pages') int totalPages
});




}
/// @nodoc
class _$PaginationResponseCopyWithImpl<T,$Res>
    implements $PaginationResponseCopyWith<T, $Res> {
  _$PaginationResponseCopyWithImpl(this._self, this._then);

  final PaginationResponse<T> _self;
  final $Res Function(PaginationResponse<T>) _then;

/// Create a copy of PaginationResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? data = null,Object? page = null,Object? total = null,Object? totalPages = null,}) {
  return _then(_self.copyWith(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as List<T>,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [PaginationResponse].
extension PaginationResponsePatterns<T> on PaginationResponse<T> {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PaginationResponse<T> value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PaginationResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PaginationResponse<T> value)  $default,){
final _that = this;
switch (_that) {
case _PaginationResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PaginationResponse<T> value)?  $default,){
final _that = this;
switch (_that) {
case _PaginationResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<T> data,  int page,  int total, @JsonKey(name: 'total_pages')  int totalPages)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PaginationResponse() when $default != null:
return $default(_that.data,_that.page,_that.total,_that.totalPages);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<T> data,  int page,  int total, @JsonKey(name: 'total_pages')  int totalPages)  $default,) {final _that = this;
switch (_that) {
case _PaginationResponse():
return $default(_that.data,_that.page,_that.total,_that.totalPages);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<T> data,  int page,  int total, @JsonKey(name: 'total_pages')  int totalPages)?  $default,) {final _that = this;
switch (_that) {
case _PaginationResponse() when $default != null:
return $default(_that.data,_that.page,_that.total,_that.totalPages);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable(genericArgumentFactories: true)

class _PaginationResponse<T> implements PaginationResponse<T> {
  const _PaginationResponse({required final  List<T> data, this.page = 0, this.total = 0, @JsonKey(name: 'total_pages') this.totalPages = 0}): _data = data;
  factory _PaginationResponse.fromJson(Map<String, dynamic> json,T Function(Object?) fromJsonT) => _$PaginationResponseFromJson(json,fromJsonT);

 final  List<T> _data;
@override List<T> get data {
  if (_data is EqualUnmodifiableListView) return _data;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_data);
}

@override@JsonKey() final  int page;
@override@JsonKey() final  int total;
@override@JsonKey(name: 'total_pages') final  int totalPages;

/// Create a copy of PaginationResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaginationResponseCopyWith<T, _PaginationResponse<T>> get copyWith => __$PaginationResponseCopyWithImpl<T, _PaginationResponse<T>>(this, _$identity);

@override
Map<String, dynamic> toJson(Object? Function(T) toJsonT) {
  return _$PaginationResponseToJson<T>(this, toJsonT);
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaginationResponse<T>&&const DeepCollectionEquality().equals(other._data, _data)&&(identical(other.page, page) || other.page == page)&&(identical(other.total, total) || other.total == total)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_data),page,total,totalPages);

@override
String toString() {
  return 'PaginationResponse<$T>(data: $data, page: $page, total: $total, totalPages: $totalPages)';
}


}

/// @nodoc
abstract mixin class _$PaginationResponseCopyWith<T,$Res> implements $PaginationResponseCopyWith<T, $Res> {
  factory _$PaginationResponseCopyWith(_PaginationResponse<T> value, $Res Function(_PaginationResponse<T>) _then) = __$PaginationResponseCopyWithImpl;
@override @useResult
$Res call({
 List<T> data, int page, int total,@JsonKey(name: 'total_pages') int totalPages
});




}
/// @nodoc
class __$PaginationResponseCopyWithImpl<T,$Res>
    implements _$PaginationResponseCopyWith<T, $Res> {
  __$PaginationResponseCopyWithImpl(this._self, this._then);

  final _PaginationResponse<T> _self;
  final $Res Function(_PaginationResponse<T>) _then;

/// Create a copy of PaginationResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? data = null,Object? page = null,Object? total = null,Object? totalPages = null,}) {
  return _then(_PaginationResponse<T>(
data: null == data ? _self._data : data // ignore: cast_nullable_to_non_nullable
as List<T>,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
