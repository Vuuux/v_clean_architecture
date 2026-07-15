part of 'splash_bloc.dart';

abstract class SplashEvent {
  const SplashEvent();
}

class SplashCheckMinVersionStarted extends SplashEvent {
  SplashCheckMinVersionStarted();
}

class SplashCheckSecuredDeviceStarted extends SplashEvent {
  SplashCheckSecuredDeviceStarted();
}

class SplashCacheAssetsImageStarted extends SplashEvent {
  SplashCacheAssetsImageStarted({required this.devicePixelRatio});

  final double devicePixelRatio;
}
