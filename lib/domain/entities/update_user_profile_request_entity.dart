import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:v_clean_architecture/domain/entities/entities.dart';

part 'update_user_profile_request_entity.freezed.dart';
part 'update_user_profile_request_entity.g.dart';

@freezed
abstract class UpdateUserProfileRequest with _$UpdateUserProfileRequest {
  const factory UpdateUserProfileRequest({
    @JsonKey(name: 'date_of_birth') String? dateOfBirth,
    AppUserGender? gender,
    @JsonKey(name: 'mobile_no') String? mobileNo,
    String? nickname,
    String? nid,
    @JsonKey(name: 'personal_message') String? personalMessage,
    @JsonKey(name: 'school_mtd_id') String? schoolMtdId,
    @JsonKey(name: 'first_name') String? firstName,
    @JsonKey(name: 'last_name') String? lastName,
    String? address,
    @JsonKey(name: 'address_id') String? addressId,
  }) = _UpdateUserProfileRequest;

  factory UpdateUserProfileRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateUserProfileRequestFromJson(json);
}
