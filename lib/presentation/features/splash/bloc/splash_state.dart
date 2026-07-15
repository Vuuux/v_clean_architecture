part of 'splash_bloc.dart';

abstract class SplashState extends Equatable {
  const SplashState();

  @override
  List<Object?> get props => [];
}

class SplashInitial extends SplashState {}

class SplashCheckMinVersionInProgress extends SplashState {}

class SplashForceUpdateRequired extends SplashState {
  const SplashForceUpdateRequired({
    required this.currentVersion,
    required this.minVersion,
    required this.appStoreId,
  });

  final String currentVersion;
  final String minVersion;
  final String appStoreId;

  @override
  List<Object?> get props => [currentVersion, minVersion, appStoreId];
}

class SplashCheckSecuredDeviceFailure extends SplashState {}

class SplashCheckSecuredDeviceSuccess extends SplashState {}

class SplashCheckMinVersionCompleted extends SplashState {}

class SplashCacheAssetsImageInProgress extends SplashState {}

class SplashCacheAssetsImageSuccess extends SplashState {}

class SplashCacheAssetsImageFailure extends SplashState {}
