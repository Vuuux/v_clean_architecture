part of 'notification_detail_bloc.dart';

abstract class NotificationDetailState extends Equatable {
  const NotificationDetailState();

  @override
  List<Object?> get props => [];
}

class NotificationDetailInitial extends NotificationDetailState {}

class NotificationDetailStartSuccess extends NotificationDetailState {}
