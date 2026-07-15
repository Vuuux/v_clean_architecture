part of 'notification_detail_bloc.dart';

abstract class NotificationDetailEvent {
  const NotificationDetailEvent();
}

class NotificationDetailStarted extends NotificationDetailEvent {
  NotificationDetailStarted();
}
