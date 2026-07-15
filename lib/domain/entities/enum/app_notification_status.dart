import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_notification_status.g.dart';

@JsonEnum(alwaysCreate: true)
enum AppNotificationStatus {
  read,
  unread,
}
