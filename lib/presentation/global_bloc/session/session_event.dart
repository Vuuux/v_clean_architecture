part of 'session_bloc.dart';

abstract class SessionEvent {
  const SessionEvent();
}

class SessionLogoutRequested extends SessionEvent {
  const SessionLogoutRequested({this.isForce = false});
  final bool isForce;
}

class SessionRetriveAuthTokensStarted extends SessionEvent {}

class SessionFetchUserDataStarted extends SessionEvent {
  SessionFetchUserDataStarted({this.shouldRedirect = true});

  final bool shouldRedirect;
}

class SessionAuthTokensUpdated extends SessionEvent {
  const SessionAuthTokensUpdated();
}

class SessionUserDataUpdated extends SessionEvent {
  const SessionUserDataUpdated({
    this.userPoint,
  });

  final int? userPoint;
}
