import 'package:freezed_annotation/freezed_annotation.dart';

part 'pagination_response.freezed.dart';
part 'pagination_response.g.dart';

@Freezed(genericArgumentFactories: true)
abstract class PaginationResponse<T> with _$PaginationResponse<T> {
  const factory PaginationResponse({
    required List<T> data,
    @Default(0) int page,
    @Default(0) int total,
    @Default(0) @JsonKey(name: 'total_pages') int totalPages,
  }) = _PaginationResponse;

  factory PaginationResponse.fromJson(
    Map<String, Object?> json,
    T Function(Object?) fromJsonT,
  ) => _$PaginationResponseFromJson(json, fromJsonT);
}
