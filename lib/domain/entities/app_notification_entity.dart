import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:v_clean_architecture/domain/entities/entities.dart';

part 'app_notification_entity.freezed.dart';
part 'app_notification_entity.g.dart';

@freezed
abstract class AppNotification with _$AppNotification {
  const factory AppNotification({
    required String id,
    @Default('') String title,
    @Default('') String body,
    @Default(AppNotificationType.notification) AppNotificationType type,
    @Default(AppNotificationStatus.unread) AppNotificationStatus status,
    String? detail,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'sent_at') DateTime? sentAt,
    @Default({}) Map<String, dynamic> data,
  }) = _AppNotification;

  factory AppNotification.fromJson(Map<String, dynamic> json) =>
      _$AppNotificationFromJson(json);
}
