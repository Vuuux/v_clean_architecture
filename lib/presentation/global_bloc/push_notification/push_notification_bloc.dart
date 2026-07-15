import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:app_core/app_core.dart';
import 'package:app_ui/app_ui.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:v_clean_architecture/app/app_environment.dart';
import 'package:v_clean_architecture/app/app_router.dart';
import 'package:v_clean_architecture/constants/constants.dart';
import 'package:v_clean_architecture/dependency_injection.dart';
import 'package:v_clean_architecture/domain/entities/entities.dart';
import 'package:v_clean_architecture/domain/interactors/interactors.dart';
import 'package:v_clean_architecture/presentation/features/notification_detail/notification_detail_page.dart';
import 'package:v_clean_architecture/presentation/utils/toast_util.dart';

part 'push_notification_bloc_listener.dart';
part 'push_notification_event.dart';
part 'push_notification_state.dart';

class PushNotificationBloc
    extends Bloc<PushNotificationEvent, PushNotificationState> {
  PushNotificationBloc._({
    required FirebaseMessaging firebaseMessaging,
    required UserInteractor userInteractor,
  }) : _firebaseMessaging = firebaseMessaging,
       _userInteractor = userInteractor,
       super(const PushNotificationInitial()) {
    on<PushNotificationPermissionRequested>(_onPermissionRequested);
    on<PushNotificationInitialized>(_onPushNotificationInitialized);
    on<PushNotificationReceived>(_onPushNotificationReceived);
    on<PushNotificationTokenUpdated>(_onPushNotificationTokenUpdated);
    on<PushNotificationTopicSubscribed>(_onTopicSubscribed);
    on<PushNotificationTopicUnsubscribed>(_onTopicUnsubscribed);
    on<PushNotificationInitialMessageChecked>(_onCheckInitialMessage);
    on<PushNotificationMessagePressed>(_onMessagePressed);
  }

  factory PushNotificationBloc.initialize() {
    return PushNotificationBloc._(
      firebaseMessaging: FirebaseMessaging.instance,
      userInteractor: DI().get<UserInteractor>(),
    );
  }

  StreamSubscription<String>? _firebaseTokenListener;
  StreamSubscription<AppNotification>? _firebaseMessageListener;
  FirebaseMessaging _firebaseMessaging;
  UserInteractor _userInteractor;

  @override
  Future<void> close() async {
    await super.close();
    await _firebaseTokenListener?.cancel();
    await _firebaseMessageListener?.cancel();
  }

  Future<void> _onPermissionRequested(
    PushNotificationPermissionRequested event,
    Emitter<PushNotificationState> emit,
  ) async {
    final result = await PermissionManager.checkNotificationPermission();
    return emit(
      PushNotificationPermissionRequestSuccess(
        state,
        isPermissionGranted: result,
      ),
    );
  }

  Future<void> _onPushNotificationInitialized(
    PushNotificationInitialized event,
    Emitter<PushNotificationState> emit,
  ) async {
    try {
      final fcmToken = await _firebaseMessaging.getToken();

      log('### [fcmToken]: $fcmToken');

      emit(PushNotificationGetFcmTokenSuccess(state, fcmToken: fcmToken));

      await _firebaseTokenListener?.cancel();
      _firebaseTokenListener = _firebaseMessaging.onTokenRefresh.listen(
        (fcmToken) => add(
          PushNotificationTokenUpdated(fcmToken: fcmToken),
        ),
      );

      await _firebaseMessageListener?.cancel();
      _firebaseMessageListener = FirebaseMessaging.onMessage
          .map(
            (firebaseMessage) => AppNotification(
              id: firebaseMessage.data['notification_id'] as String,
              title: firebaseMessage.notification?.title ?? '',
              body: firebaseMessage.notification?.body ?? '',
            ),
          )
          .listen(
            (notification) => add(
              PushNotificationReceived(notification: notification),
            ),
          );

      _firebaseMessageListener = FirebaseMessaging.onMessageOpenedApp
          .map(
            (firebaseMessage) => AppNotification(
              id: firebaseMessage.data['notification_id'] as String,
              title: firebaseMessage.notification?.title ?? '',
              body: firebaseMessage.notification?.body ?? '',
            ),
          )
          .listen(
            (notification) => add(
              PushNotificationMessagePressed(notification: notification),
            ),
          );

      add(PushNotificationTopicSubscribed(topic: AppEnvironment.fcmTopic));
    } catch (error) {
      log('### [FCM] Push Notification Initialize Error: $error');
    }
  }

  Future<void> _onPushNotificationReceived(
    PushNotificationReceived event,
    Emitter<PushNotificationState> emit,
  ) async {
    emit(
      PushNotificationReceiveSuccess(
        state,
        notification: event.notification,
      ),
    );
  }

  Future<void> _onPushNotificationTokenUpdated(
    PushNotificationTokenUpdated event,
    Emitter<PushNotificationState> emit,
  ) async {
    try {
      var fcmToken = event.fcmToken ?? state.fcmToken;
      if (event.fcmToken == null) {
        fcmToken = await _firebaseMessaging.getToken();
      }
      emit(PushNotificationUpdateFcmTokenInProgress(state));
      await _userInteractor.updateNotificationToken(
        token: fcmToken!,
        isIos: Platform.isIOS,
      );
      emit(
        PushNotificationUpdateFcmTokenSuccess(state, fcmToken: event.fcmToken),
      );
    } catch (_) {
      emit(PushNotificationUpdateFcmTokenFailure(state));
    }
  }

  Future<void> _onTopicSubscribed(
    PushNotificationTopicSubscribed event,
    Emitter<PushNotificationState> emit,
  ) async {
    await _firebaseMessaging.subscribeToTopic(event.topic);
  }

  Future<void> _onTopicUnsubscribed(
    PushNotificationTopicUnsubscribed event,
    Emitter<PushNotificationState> emit,
  ) async {
    await _firebaseMessaging.unsubscribeFromTopic(event.topic);
  }

  Future<void> _onCheckInitialMessage(
    PushNotificationInitialMessageChecked event,
    Emitter<PushNotificationState> emit,
  ) async {
    final initialMessage = await _firebaseMessaging.getInitialMessage();
    if (initialMessage != null) {
      log('### [FCM] Initial message received: ${initialMessage.messageId}');
      final notification = AppNotification(
        id: initialMessage.data['notification_id'] as String,
        title: initialMessage.notification?.title ?? '',
        body: initialMessage.notification?.body ?? '',
        data: initialMessage.data,
      );
      add(PushNotificationMessagePressed(notification: notification));
    }
  }

  Future<void> _onMessagePressed(
    PushNotificationMessagePressed event,
    Emitter<PushNotificationState> emit,
  ) async {
    emit(
      PushNotificationMessagePressSuccess(
        state,
        notification: event.notification,
      ),
    );
  }
}
