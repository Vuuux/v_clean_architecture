import 'package:app_core/app_core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:v_clean_architecture/app/app_environment.dart';
import 'package:v_clean_architecture/domain/entities/enum/enum.dart';

part 'app_user_entity.freezed.dart';
part 'app_user_entity.g.dart';

@freezed
abstract class AppUser with _$AppUser {
  const factory AppUser({
    @JsonKey(name: 'user_id') required String userId,
    @Default('') String id,
    @Default('') String username,
    String? avatar,
    String? email,
    String? address,
    AppUserGender? gender,
    String? nickname,
    String? org,
    String? nid,
    String? code,
    AppUserStage? stage,
    AppUserStatus? status,
    @JsonKey(name: 'address_id') String? addressId,
    @JsonKey(name: 'cover_photo') String? coverPhoto,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
    @JsonKey(name: 'date_of_birth') String? dateOfBirth,
    @JsonKey(name: 'en_first_name') String? enFirstName,
    @JsonKey(name: 'en_last_name') String? enLastName,
    @JsonKey(name: 'mobile_no') String? mobileNo,
    @JsonKey(name: 'is_following') bool? isFollowing,
  }) = _AppUser;

  factory AppUser.fromJson(Map<String, dynamic> json) =>
      _$AppUserFromJson(json);

  factory AppUser.empty() {
    return const AppUser(
      userId: '',
    );
  }
}

extension AppUserExtension on AppUser {
  String get fullName {
    final firstName = enFirstName ?? '';
    final lastName = enLastName ?? '';
    return '$firstName $lastName'.trim();
  }

  String get displayFullName {
    return (nickname.isNotEmptyOrNull) ? '$fullName ($nickname)' : fullName;
  }

  String get fullAvatarUrl {
    return avatar != null
        ? avatar.getFileUrl(
            host: AppEnvironment.mediaHost,
            size: ImageSize.medium,
          )
        : '';
  }
}
