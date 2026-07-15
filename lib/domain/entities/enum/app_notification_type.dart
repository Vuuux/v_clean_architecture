import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_notification_type.g.dart';

@JsonEnum(alwaysCreate: true)
enum AppNotificationType {
  @JsonValue('notification')
  notification,
  @JsonValue('image')
  image,
  @JsonValue('video')
  video,
  @JsonValue('otp')
  otp
  ;

  IconData get icon {
    switch (this) {
      case AppNotificationType.notification:
        return Icons.notifications;
      case AppNotificationType.image:
        return Icons.image;
      case AppNotificationType.video:
        return Icons.video_collection;
      case AppNotificationType.otp:
        return Icons.password;
    }
  }
}
