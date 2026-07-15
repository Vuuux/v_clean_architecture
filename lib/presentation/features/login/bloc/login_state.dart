part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {}

class LoginInProgress extends LoginState {}

class LoginFailure extends LoginState {
  const LoginFailure({required this.error});

  final dynamic error;

  @override
  List<Object?> get props => [error];
}

class LoginSocialInProgress extends LoginState {}

class LoginSocialFailure extends LoginState {
  const LoginSocialFailure({required this.error});

  final dynamic error;

  @override
  List<Object?> get props => [error];
}

class LoginSuccess extends LoginState {
  const LoginSuccess({
    this.needOnboard = false,
    this.provider,
  });

  final bool needOnboard;
  final OAuthProvider? provider;
}

class LoginLocked extends LoginState {
  final String message;
  const LoginLocked({required this.message});
  @override
  List<Object?> get props => [message];
}
