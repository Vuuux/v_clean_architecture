import 'package:app_core/app_core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:v_clean_architecture/app/app_environment.dart';
import 'package:v_clean_architecture/constants/assets.dart';
import 'package:v_clean_architecture/dependency_injection.dart';
import 'package:v_clean_architecture/domain/interactors/interactors.dart';

part 'splash_event.dart';
part 'splash_state.dart';

final class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc({
    required AppConfigInteractor systemConfigInteractor,
  }) : _appConfigInteractor = systemConfigInteractor,
       super(SplashInitial()) {
    on<SplashCheckSecuredDeviceStarted>(_onCheckSecuredDevice);
    on<SplashCheckMinVersionStarted>(_onCheckMinVersion);
    on<SplashCacheAssetsImageStarted>(_onCacheAssetsImage);
  }

  factory SplashBloc.initialize() {
    return SplashBloc(
      systemConfigInteractor: DI().get<AppConfigInteractor>(),
    );
  }

  final AppConfigInteractor _appConfigInteractor;

  Future<void> _onCheckSecuredDevice(
    SplashCheckSecuredDeviceStarted event,
    Emitter<SplashState> emit,
  ) async {
    try {
      // final isSecure = await SecurityService().isSecure();
      final isSecure = true;
      if (!isSecure) {
        emit(SplashCheckSecuredDeviceFailure());
        return;
      }
      emit(SplashCheckSecuredDeviceSuccess());
    } catch (e) {
      // If error, allow user to continue
      emit(SplashCheckSecuredDeviceSuccess());
    }
  }

  Future<void> _onCheckMinVersion(
    SplashCheckMinVersionStarted event,
    Emitter<SplashState> emit,
  ) async {
    emit(SplashCheckMinVersionInProgress());
    try {
      final systemConfig = await _appConfigInteractor.getSystemAppVersion();
      final packageInfo = await PackageInfo.fromPlatform();
      final currentVersion = packageInfo.version;

      if (systemConfig.value != null && systemConfig.value!.isNotEmpty) {
        final minVersion = systemConfig.value![0];
        final appStoreId = systemConfig.value!.length > 1
            ? systemConfig.value![1]
            : '';

        // Compare versions
        if (_isVersionLessThan(currentVersion, minVersion)) {
          emit(
            SplashForceUpdateRequired(
              currentVersion: currentVersion,
              minVersion: minVersion,
              appStoreId: appStoreId,
            ),
          );
          return;
        }
      }

      emit(SplashCheckMinVersionCompleted());
    } catch (e) {
      // If error, allow user to continue
      emit(SplashCheckMinVersionCompleted());
    }
  }

  bool _isVersionLessThan(String current, String minimum) {
    final currentParts = current.split('.').map(int.parse).toList();
    final minimumParts = minimum.split('.').map(int.parse).toList();

    for (var i = 0; i < minimumParts.length; i++) {
      if (i >= currentParts.length) return true;
      if (currentParts[i] < minimumParts[i]) return true;
      if (currentParts[i] > minimumParts[i]) return false;
    }

    return false;
  }

  Future<void> _onCacheAssetsImage(
    SplashCacheAssetsImageStarted event,
    Emitter<SplashState> emit,
  ) async {
    if (!await _shouldCacheAssetImage(event.devicePixelRatio)) {
      emit(SplashCacheAssetsImageSuccess());
      return;
    }
    emit(SplashCacheAssetsImageInProgress());
    try {
      emit(SplashCacheAssetsImageSuccess());
    } catch (err) {
      emit(SplashCacheAssetsImageFailure());
    }
  }

  Future<void> _cacheAssetImage(String imagePath) async {
    final cacheManager = DefaultCacheManager();
    final cacheFile = await cacheManager.getFileFromCache(imagePath);
    if (cacheFile == null) {
      await cacheManager.getSingleFile(imagePath);
    }
  }

  Future<bool> _shouldCacheAssetImage(double dpr) async {
    // get last image file and check if it already cached
    final cachedFile = await DefaultCacheManager().getFileFromCache(
      AssetConstants.logo.getAssetImageUrl(
        host: AppEnvironment.mediaHost,
        devicePixelRatio: dpr,
      ),
    );
    return cachedFile == null;
  }
}
