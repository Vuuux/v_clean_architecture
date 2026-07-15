import 'package:app_core/app_core.dart';
import 'package:v_clean_architecture/domain/entities/entities.dart';
import 'package:v_clean_architecture/domain/repositories/repositories.dart';

abstract class AuthInteractor {
  Future<OAuthUrl> getOAuthUrl({
    required String clientId,
    required OAuthProvider provider,
  });

  Future<AuthResult> signIn({
    required String username,
    required String password,
  });

  Future<String> signInWithGoogle();

  Future<String> signInWithLine();

  Future<String> signInWithApple();

  Future<AuthResult> handleOAuthCallback({
    required String data,
    required OAuthProvider provider,
  });

  Future<AuthTokens?> getLocalAuthTokens();

  Future<void> signOut();

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

final class AuthInteractorImpl implements AuthInteractor {
  AuthInteractorImpl({required AuthRepository repository})
    : _repository = repository;

  final AuthRepository _repository;

  @override
  Future<OAuthUrl> getOAuthUrl({
    required String clientId,
    required OAuthProvider provider,
  }) {
    return _repository.getOAuthUrl(clientId: clientId, provider: provider);
  }

  @override
  Future<String> signInWithGoogle() {
    return _repository.signInWithGoogle();
  }

  @override
  Future<String> signInWithLine() {
    return _repository.signInWithLine();
  }

  @override
  Future<String> signInWithApple() {
    return _repository.signInWithApple();
  }

  @override
  Future<AuthResult> handleOAuthCallback({
    required String data,
    required OAuthProvider provider,
  }) async {
    final encryptedData = data;
    return _repository.handleOAuthCallback(
      encryptedData: encryptedData,
      provider: provider,
    );
  }

  @override
  Future<AuthResult> signIn({
    required String username,
    required String password,
  }) async {
    // Demo mode: bypass encryption and use password directly
    return _repository.signIn(
      username: username,
      encryptedPassword: password,
    );
    // Production mode: uncomment below and remove above
    // final publicKey = await _repository.getPublicKey();
    // final encryptedPassword = password.encryptWithPublicKey(publicKey);
    // return _repository.signIn(
    //   username: username,
    //   encryptedPassword: encryptedPassword,
    // );
  }

  @override
  Future<AuthTokens?> getLocalAuthTokens() {
    return _repository.getLocalAuthTokens();
  }

  @override
  Future<void> signOut() {
    return _repository.signOut();
  }

  @override
  Future<AuthTokens> exchangeToken() async {
    return _repository.exchangeToken();
  }

  @override
  Future<bool> submitForgetPassword({required String email}) {
    return _repository.submitForgetPassword(email: email);
  }

  @override
  Future<bool> changeForgetPassword({
    required String token,
    required String newPassword,
  }) {
    return _repository.changeForgetPassword(
      token: token,
      newPassword: newPassword,
    );
  }

  @override
  Future<bool> changeUserPassword({
    required String currentPassword,
    required String newPassword,
  }) {
    return _repository.changeUserPassword(
      currentPassword: currentPassword,
      newPassword: newPassword,
    );
  }

  @override
  Future<void> setLocalAuthToken(AuthTokens token) {
    return _repository.setLocalAuthToken(token);
  }
}
