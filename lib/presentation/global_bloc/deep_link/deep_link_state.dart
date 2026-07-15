part of 'deep_link_bloc.dart';

abstract class DeepLinkState extends Equatable {
  const DeepLinkState();

  @override
  List<Object?> get props => [];
}

class DeepLinkInitial extends DeepLinkState {}

class DeepLinkHandleInProgress extends DeepLinkState {
  const DeepLinkHandleInProgress();
}

class DeepLinkHandleSuccess extends DeepLinkState {
  const DeepLinkHandleSuccess({
    required this.routeName,
    required this.shouldLogin,
    required this.shouldPushNewPage,
    this.arguments,
  });

  final String routeName;
  final dynamic arguments;
  final bool shouldLogin;
  final bool shouldPushNewPage;

  @override
  List<Object?> get props => [
    routeName,
    arguments,
    shouldLogin,
    shouldPushNewPage,
  ];
}
