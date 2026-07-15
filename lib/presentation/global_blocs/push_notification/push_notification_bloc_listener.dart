part of './push_notification_bloc.dart';

extension PushNotificationBlocExtension on PushNotificationBloc {
  void listener(PushNotificationState state) {
    final router = AppRouter.shared.router;
    switch (state.runtimeType) {
      case const (PushNotificationReceiveSuccess):
        final notification =
            (state as PushNotificationReceiveSuccess).notification;
        showToast(
          title: notification.title,
          description: notification.body,
          type: AppToastType.info,
          onTap: () {
            add(PushNotificationMessagePressed(notification: notification));
          },
        );
        return;
      case const (PushNotificationMessagePressSuccess):
        final notification =
            (state as PushNotificationMessagePressSuccess).notification;
        router.pushNamed(
          RouteNames.notificationDetail,
          extra: NotificationDetailPageArguments(notiId: notification.id),
        );
        return;
    }
  }
}
