part of 'deep_link_bloc.dart';

abstract class DeepLinksEvent {
  const DeepLinksEvent();
}

class DeepLinkStarted extends DeepLinksEvent {
  const DeepLinkStarted();
}

class DeepLinkReceived extends DeepLinksEvent {
  const DeepLinkReceived(this.uri);
  final Uri uri;
}
