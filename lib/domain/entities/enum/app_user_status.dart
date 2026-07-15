import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_user_status.g.dart';

@JsonEnum(alwaysCreate: true)
enum AppUserStatus {
  @JsonValue('new')
  fresh,
  @JsonValue('pending')
  pending,
  @JsonValue('active')
  active,
  @JsonValue('inactive')
  inactive,
}
