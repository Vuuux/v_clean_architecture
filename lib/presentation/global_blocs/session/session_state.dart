part of 'session_bloc.dart';

abstract class SessionState extends Equatable {
  const SessionState({
    this.authTokens,
    this.userData,
  });

  final AuthTokens? authTokens;
  final AppUser? userData;

  @override
  List<Object?> get props => [
    authTokens,
    userData,
  ];
}

class SessionInitial extends SessionState {
  const SessionInitial() : super();
}

class SessionRetriveLocalAuthTokensSuccess extends SessionState {
  const SessionRetriveLocalAuthTokensSuccess({super.authTokens});
}

class SessionFetchUserDataInProgress extends SessionState {
  SessionFetchUserDataInProgress(SessionState state)
    : super(
        authTokens: state.authTokens,
        userData: state.userData,
      );
}

class SessionFetchUserDataSuccess extends SessionState {
  SessionFetchUserDataSuccess(
    SessionState state, {
    required AppUser userData,
    this.shouldRedirect = true,
  }) : super(
         authTokens: state.authTokens,
         userData: userData,
       );

  final bool shouldRedirect;
}

class SessionNetworkError extends SessionState {
  SessionNetworkError(SessionState state)
    : super(
        authTokens: state.authTokens,
        userData: state.userData,
      );
}

class SessionUserDataUpdateSuccess extends SessionState {
  SessionUserDataUpdateSuccess(
    SessionState state, {
    AppUser? userData,
  }) : super(
         authTokens: state.authTokens,
         userData: userData ?? state.userData,
       );
}

class SessionAuthTokensUpdateSuccess extends SessionState {
  const SessionAuthTokensUpdateSuccess({super.authTokens});
}

class SessionLogoutInProgress extends SessionState {
  const SessionLogoutInProgress() : super(authTokens: null);
}

class SessionLogoutSuccess extends SessionState {
  const SessionLogoutSuccess({
    this.isForce = false,
  }) : super(authTokens: null);
  final bool isForce;
}
