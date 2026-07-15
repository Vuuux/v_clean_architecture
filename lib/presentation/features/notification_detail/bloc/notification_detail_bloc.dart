import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'notification_detail_event.dart';
part 'notification_detail_state.dart';

final class NotificationDetailBloc extends Bloc<NotificationDetailEvent, NotificationDetailState> {
  NotificationDetailBloc() : super(NotificationDetailInitial()) {
    on<NotificationDetailStarted>(_onNotificationDetailStarted);
  }

  factory NotificationDetailBloc.initialize() {
    return NotificationDetailBloc();
  }

  Future<void> _onNotificationDetailStarted(
    NotificationDetailStarted event,
    Emitter<NotificationDetailState> emit,
  ) async {
    emit(NotificationDetailStartSuccess());
  }
}
