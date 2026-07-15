part of 'push_notification_bloc.dart';

abstract class PushNotificationState extends Equatable {
  const PushNotificationState({
    this.isPermissionGranted = false,
    this.fcmToken,
  });

  final bool isPermissionGranted;
  final String? fcmToken;

  @override
  List<Object?> get props => [
    isPermissionGranted,
    fcmToken,
  ];
}

class PushNotificationInitial extends PushNotificationState {
  const PushNotificationInitial() : super();
}

class PushNotificationPermissionRequestSuccess extends PushNotificationState {
  PushNotificationPermissionRequestSuccess(
    PushNotificationState state, {
    required super.isPermissionGranted,
  }) : super(
         fcmToken: state.fcmToken,
       );
}

class PushNotificationGetFcmTokenSuccess extends PushNotificationState {
  PushNotificationGetFcmTokenSuccess(
    PushNotificationState state, {
    required super.fcmToken,
  }) : super(
         isPermissionGranted: state.isPermissionGranted,
       );
}

class PushNotificationReceiveSuccess extends PushNotificationState {
  PushNotificationReceiveSuccess(
    PushNotificationState state, {
    required this.notification,
  }) : super(
         fcmToken: state.fcmToken,
         isPermissionGranted: state.isPermissionGranted,
       );

  final AppNotification notification;

  @override
  List<Object?> get props => [notification];
}

class PushNotificationUpdateFcmTokenInProgress extends PushNotificationState {
  PushNotificationUpdateFcmTokenInProgress(PushNotificationState state)
    : super(
        isPermissionGranted: state.isPermissionGranted,
        fcmToken: state.fcmToken,
      );
}

class PushNotificationUpdateFcmTokenSuccess extends PushNotificationState {
  PushNotificationUpdateFcmTokenSuccess(
    PushNotificationState state, {
    required super.fcmToken,
  }) : super(
         isPermissionGranted: state.isPermissionGranted,
       );
}

class PushNotificationUpdateFcmTokenFailure extends PushNotificationState {
  PushNotificationUpdateFcmTokenFailure(PushNotificationState state)
    : super(
        isPermissionGranted: state.isPermissionGranted,
        fcmToken: state.fcmToken,
      );
}

class PushNotificationMessagePressSuccess extends PushNotificationState {
  PushNotificationMessagePressSuccess(
    PushNotificationState state, {
    required this.notification,
  }) : super(
         isPermissionGranted: state.isPermissionGranted,
         fcmToken: state.fcmToken,
       );

  final AppNotification notification;

  @override
  List<Object?> get props => [
    ...super.props,
    notification,
  ];
}
