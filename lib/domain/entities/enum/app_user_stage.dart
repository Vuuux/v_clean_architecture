import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_user_stage.g.dart';

@JsonEnum(alwaysCreate: true)
enum AppUserStage {
  @JsonValue('NEW')
  fresh,
  @JsonValue('OTP_VERIFIED')
  otpVerified,
  @JsonValue('USER_CREATED')
  userCreated,
  @JsonValue('INFO_UPDATED')
  infoUpdated,
  @JsonValue('SCHOOL_UPDATED')
  schoolUpdated,
  @JsonValue('PROFILE_UPDATED')
  profileUpdated,
  @JsonValue('AVATAR_UPDATED')
  avatarUpdated,
  @JsonValue('COMPLETED')
  completed,
}

extension AppUserStageExtension on AppUserStage {
  bool needGoToOnboarding() {
    return this != AppUserStage.completed && this != AppUserStage.avatarUpdated;
  }
}
