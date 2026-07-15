// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_notification_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AppNotification _$AppNotificationFromJson(Map<String, dynamic> json) =>
    _AppNotification(
      id: json['id'] as String,
      title: json['title'] as String? ?? '',
      body: json['body'] as String? ?? '',
      type:
          $enumDecodeNullable(_$AppNotificationTypeEnumMap, json['type']) ??
          AppNotificationType.notification,
      status:
          $enumDecodeNullable(_$AppNotificationStatusEnumMap, json['status']) ??
          AppNotificationStatus.unread,
      detail: json['detail'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      sentAt: json['sent_at'] == null
          ? null
          : DateTime.parse(json['sent_at'] as String),
      data: json['data'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$AppNotificationToJson(_AppNotification instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'body': instance.body,
      'type': _$AppNotificationTypeEnumMap[instance.type]!,
      'status': _$AppNotificationStatusEnumMap[instance.status]!,
      'detail': instance.detail,
      'created_at': instance.createdAt?.toIso8601String(),
      'sent_at': instance.sentAt?.toIso8601String(),
      'data': instance.data,
    };

const _$AppNotificationTypeEnumMap = {
  AppNotificationType.notification: 'notification',
  AppNotificationType.image: 'image',
  AppNotificationType.video: 'video',
  AppNotificationType.otp: 'otp',
};

const _$AppNotificationStatusEnumMap = {
  AppNotificationStatus.read: 'read',
  AppNotificationStatus.unread: 'unread',
};
