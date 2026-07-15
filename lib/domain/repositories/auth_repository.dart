import 'package:v_clean_architecture/domain/entities/entities.dart';

abstract class AuthRepository {
  Future<OAuthUrl> getOAuthUrl({
    required String clientId,
    required OAuthProvider provider,
  });

  Future<AuthResult> signIn({
    required String username,
    required String encryptedPassword,
  });

  Future<String> signInWithGoogle();

  Future<String> signInWithLine();

  Future<String> signInWithApple();

  Future<String> getPublicKey();

  Future<AuthResult> handleOAuthCallback({
    required String encryptedData,
    required OAuthProvider provider,
  });

  Future<AuthTokens?> getLocalAuthTokens();

  Future<void> signOut();

  Future<AuthTokens> refreshToken(String refreshToken);

  Future<AuthTokens> exchangeToken();

  Future<bool> submitForgetPassword({required String email});

  Future<bool> changeForgetPassword({
    required String token,
    required String newPassword,
  });

  Future<bool> changeUserPassword({
    required String currentPassword,
    required String newPassword,
  });

  Future<void> setLocalAuthToken(AuthTokens token);
}
