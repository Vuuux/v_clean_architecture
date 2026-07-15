import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:v_clean_architecture/domain/entities/entities.dart';

part 'auth_result_entity.freezed.dart';
part 'auth_result_entity.g.dart';

@freezed
abstract class AuthResult with _$AuthResult {
  const factory AuthResult({
    @Default(AppUserStatus.fresh) AppUserStatus status,
    @JsonKey(name: 'onboarding_token') String? onboardingToken,
    @JsonKey(name: 'access_token') String? accessToken,
    @JsonKey(name: 'refresh_token') String? refreshToken,
    @JsonKey(name: 'is_register') @Default(false) bool isRegister,
  }) = _AuthResult;

  factory AuthResult.blank() => AuthResult(
    onboardingToken: 'sample',
    accessToken: 'sample',
    refreshToken: 'sample',
    isRegister: true,
  );

  factory AuthResult.fromJson(Map<String, dynamic> json) =>
      _$AuthResultFromJson(json);
}
