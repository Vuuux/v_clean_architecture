import 'package:app_core/app_core.dart';
import 'package:v_clean_architecture/domain/entities/entities.dart';

/// ============================================================================
/// USER REMOTE SOURCE - User Profile API
/// ============================================================================
///
/// **How User Data relates to Auth:**
///
/// 1. User logs in → receives tokens
/// 2. Tokens contain user ID (in JWT payload)
/// 3. /me endpoint uses the access token to identify user
/// 4. Server extracts user ID from token, returns that user's profile
///
/// **Why separate Auth and User APIs?**
/// - Auth handles credentials → managed by Identity Service
/// - User handles profile data → managed by User Service
/// - Microservices architecture: separation of concerns
/// - Different scaling requirements
/// ============================================================================

class _UserApi {
  static const String baseUser = '/v/user';

  static const String baseMe = '/v/me';

  static const String getMeProfile = baseMe;

  static const String baseAvatarMe = '$baseMe/avatar';

  static const String updateUserAvatar = '$baseAvatarMe/update';

  static String updateCurrentUserDevice(String baseUser) =>
      '$baseMe/events/$baseUser/delete';

  static const String follow = '/v1/user/follow'; // POST { follower_id }
  static const String unfollow = '/v1/user/unfollow'; // POST { follower_id }
}

abstract class UserRemoteSource {
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

final class UserRemoteSourceImpl implements UserRemoteSource {
  UserRemoteSourceImpl({
    required BaseHttpClient host1Client,
    required BaseHttpClient host2Client,
  }) : _host1Client = host1Client,
       _host2Client = host2Client;

  final BaseHttpClient _host2Client;
  final BaseHttpClient _host1Client;

  @override
  Future<AppUser> getCurrentUserProfile() async {
    // =========================================================================
    // DEMO: Return realistic sample user data
    // =========================================================================
    // In production:
    // 1. This endpoint is called with the access token in Authorization header
    // 2. Server validates the token and extracts user ID
    // 3. Server fetches user data from database
    // 4. Server returns user profile
    //
    // If token is invalid/expired, server returns 401 Unauthorized
    // The HTTP client interceptor then attempts token refresh
    // =========================================================================

// Simulate network delay for realism
    await Future<void>.delayed(const Duration(milliseconds: 600));

    return AppUser(
      userId: 'usr_demo_12345',
      id: 'usr_demo_12345',
      username: 'john_doe',
      email: 'john.doe@example.com',
      nickname: 'John',
      enFirstName: 'John',
      enLastName: 'Doe',
      mobileNo: '+1 234 567 8900',
      dateOfBirth: '1990-05-15',
      gender: AppUserGender.male,
      address: '123 Demo Street, San Francisco, CA 94102',
      stage: AppUserStage.completed,
      status: AppUserStatus.active,
      createdAt: DateTime.now().subtract(const Duration(days: 365)).toIso8601String(),
      updatedAt: DateTime.now().toIso8601String(),
    );

    // Production mode:
    // final response = await _host2Client.get(_UserApi.getMeProfile);
    // return AppUser.fromJson(response as Map<String, dynamic>);
  }

  @override
  Future<bool> updateUserAvatar({required String avatarUrl}) async {
    final response = await _host2Client.post(
      _UserApi.updateUserAvatar,
      body: {'avatar': avatarUrl},
    );
    return response is Map<String, dynamic> && response['is_success'] == true;
  }

  @override
  Future<bool> updateNotificationToken({
    required String token,
    required bool isIos,
  }) async {
    // =========================================================================
    // PUSH NOTIFICATION TOKEN REGISTRATION
    // =========================================================================
    // After login, register the device's push notification token
    // This links the device to the user account for push notifications
    // =========================================================================

    final response = await _host1Client.post(
      _UserApi.updateCurrentUserDevice('SAMPLE_ID'),
      body: {
        'notification_token': token,
        'platform': isIos ? 'ios' : 'android',
      },
    );
    return response is Map<String, dynamic> && response['is_success'] == true;
  }

  @override
  Future<AppUser> getUserProfileById({required String userId}) async {
    final response = await _host2Client.get('${_UserApi.baseUser}/$userId');
    return AppUser.fromJson(response as Map<String, dynamic>);
  }

  @override
  Future<bool> follow(String followerId) async {
    final res = await _host2Client.post(
      _UserApi.follow,
      body: {'follower_id': followerId},
    );
    return res is Map<String, dynamic> && res['is_success'] == true;
  }

  @override
  Future<bool> unfollow(String followerId) async {
    final res = await _host2Client.post(
      _UserApi.unfollow,
      body: {'follower_id': followerId},
    );
    return res is Map<String, dynamic> && res['is_success'] == true;
  }

  @override
  Future<AppUser> updateUserProfile(UpdateUserProfileRequest request) {
    throw UnimplementedError();
  }
}
