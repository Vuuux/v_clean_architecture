import 'package:v_clean_architecture/data/sources/remote/remote.dart';
import 'package:v_clean_architecture/domain/entities/entities.dart';
import 'package:v_clean_architecture/domain/repositories/repositories.dart';

final class AppConfigRepositoryImpl implements AppConfigRepository {
  AppConfigRepositoryImpl({required AppConfigRemoteSource remoteSource})
    : _remoteSource = remoteSource;

  final AppConfigRemoteSource _remoteSource;

  @override
  Future<Pagination<AppConfig>> getAllAppConfigs() {
    return _remoteSource.getAllAppConfigs();
  }

  @override
  Future<AppConfig> getAppConfigByKey(String key) {
    return _remoteSource.getAppConfigByKey(key);
  }

  @override
  Future<AppConfig> getAppVersion() {
    return _remoteSource.getAppVersion();
  }
}
