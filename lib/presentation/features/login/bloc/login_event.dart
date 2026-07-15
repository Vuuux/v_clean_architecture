part of 'login_bloc.dart';

abstract class LoginEvent {
  const LoginEvent();
}

class LoginStarted extends LoginEvent {
  LoginStarted({
    required this.username,
    required this.password,
  });

  final String username;
  final String password;
}

class LoginSocialPressed extends LoginEvent {
  LoginSocialPressed({required this.provider});

  final OAuthProvider provider;
}

class LoginSocialCallbackStarted extends LoginEvent {
  LoginSocialCallbackStarted({
    required this.data,
    required this.provider,
  });

  final String data;
  final OAuthProvider provider;
}
