part of 'push_notification_bloc.dart';

class PushNotificationEvent {
  const PushNotificationEvent();
}

class PushNotificationInitialized extends PushNotificationEvent {}

class PushNotificationPermissionRequested extends PushNotificationEvent {}

class PushNotificationReceived extends PushNotificationEvent {
  PushNotificationReceived({required this.notification});
  final AppNotification notification;
}

class PushNotificationTokenUpdated extends PushNotificationEvent {
  const PushNotificationTokenUpdated({this.fcmToken});
  final String? fcmToken;
}

class PushNotificationTopicSubscribed extends PushNotificationEvent {
  PushNotificationTopicSubscribed({required this.topic});
  final String topic;
}

class PushNotificationTopicUnsubscribed extends PushNotificationEvent {
  PushNotificationTopicUnsubscribed({required this.topic});
  final String topic;
}

class PushNotificationInitialMessageChecked extends PushNotificationEvent {
  PushNotificationInitialMessageChecked();
}

class PushNotificationMessagePressed extends PushNotificationEvent {
  PushNotificationMessagePressed({required this.notification});

  final AppNotification notification;
}
