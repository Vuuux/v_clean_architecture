import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_user_gender.g.dart';

@JsonEnum(alwaysCreate: true)
enum AppUserGender {
  @JsonValue('')
  undefined,
  @JsonValue('male')
  male,
  @JsonValue('female')
  female,
  @JsonValue('others')
  others,
}
