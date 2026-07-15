import 'dart:async';

import 'package:v_clean_architecture/data/data.dart';
import 'package:v_clean_architecture/domain/entities/entities.dart';
import 'package:v_clean_architecture/domain/repositories/repositories.dart';

class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl({
    required UserLocalStorage localStorage,
    required UserRemoteSource remoteSource,
    required AuthLocalStorage authLocalStorage,
  }) : _localStorage = localStorage,
       _remoteSource = remoteSource,
       _authLocalStorage = authLocalStorage;

  final UserLocalStorage _localStorage;
  final UserRemoteSource _remoteSource;
  final AuthLocalStorage _authLocalStorage;

  @override
  Future<AppUser> getCurrentUserProfile() async {
    final user = await _remoteSource.getCurrentUserProfile();
    unawaited(_authLocalStorage.setLoggedInUserId(user.id));
    unawaited(_localStorage.setUserData(user));
    return user;
  }

  @override
  Future<bool> updateUserAvatar({required String avatarUrl}) {
    return _remoteSource.updateUserAvatar(avatarUrl: avatarUrl);
  }

  @override
  Future<AppUser> updateUserProfile(
    UpdateUserProfileRequest updatedUserProfileRequest,
  ) {
    return _remoteSource.updateUserProfile(
      updatedUserProfileRequest,
    );
  }

  @override
  Future<bool> updateNotificationToken({
    required String token,
    required bool isIos,
  }) {
    return _remoteSource.updateNotificationToken(
      token: token,
      isIos: isIos,
    );
  }

  @override
  Future<AppUser> getUserProfileById({required String userId}) {
    return _remoteSource.getUserProfileById(userId: userId);
  }

  @override
  Future<bool> follow(String followerId) {
    return _remoteSource.follow(followerId);
  }

  @override
  Future<bool> unfollow(String followerId) {
    return _remoteSource.unfollow(followerId);
  }
}
