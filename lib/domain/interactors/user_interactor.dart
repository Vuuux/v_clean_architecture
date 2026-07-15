import 'package:v_clean_architecture/domain/entities/entities.dart';
import 'package:v_clean_architecture/domain/repositories/repositories.dart';

abstract class UserInteractor {
  Future<AppUser> getCurrentUserProfile();
  Future<AppUser> getUserProfileById({required String userId});
  Future<AppUser> updateUserProfile(UpdateUserProfileRequest request);
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

final class UserInteractorImpl implements UserInteractor {
  UserInteractorImpl({
    required UserRepository repository,
  }) : _repository = repository;

  final UserRepository _repository;

  @override
  Future<AppUser> getCurrentUserProfile() {
    return _repository.getCurrentUserProfile();
  }

  @override
  Future<bool> updateUserAvatar({required String avatarUrl}) {
    return _repository.updateUserAvatar(avatarUrl: avatarUrl);
  }

  @override
  Future<AppUser> updateUserProfile(UpdateUserProfileRequest request) {
    return _repository.updateUserProfile(request);
  }

  @override
  Future<bool> updateNotificationToken({
    required String token,
    required bool isIos,
  }) {
    return _repository.updateNotificationToken(
      token: token,
      isIos: isIos,
    );
  }

  @override
  Future<bool> follow(String followerId) => _repository.follow(followerId);

  @override
  Future<bool> unfollow(String followerId) => _repository.unfollow(followerId);

  @override
  Future<AppUser> getUserProfileById({required String userId}) {
    return _repository.getUserProfileById(userId: userId);
  }
}
