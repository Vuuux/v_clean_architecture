import 'package:freezed_annotation/freezed_annotation.dart';

part 'pagination_entity.freezed.dart';

@Freezed(genericArgumentFactories: true)
abstract class Pagination<T> with _$Pagination<T> {
  const factory Pagination({
    required List<T> data,
    @Default(0) int page,
    @Default(0) int total,
    @Default(0) @JsonKey(name: 'total_pages') int totalPages,
  }) = _Pagination;
}
