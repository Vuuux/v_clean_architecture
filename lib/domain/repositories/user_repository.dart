import 'package:v_clean_architecture/domain/entities/entities.dart';

abstract class UserRepository {
  Future<AppUser> getCurrentUserProfile();
  Future<AppUser> getUserProfileById({required String userId});
  Future<AppUser> updateUserProfile(
    UpdateUserProfileRequest updatedUserProfileRequest,
  );
  Future<bool> updateUserAvatar({
    required String avatarUrl,
  });

  Future<bool> updateNotificationToken({
    required String token,
    required bool isIos,
  });

  Future<bool> follow(String followerId);
  Future<bool> unfollow(String followerId);
}
