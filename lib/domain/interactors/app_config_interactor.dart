import 'package:v_clean_architecture/domain/entities/entities.dart';
import 'package:v_clean_architecture/domain/repositories/repositories.dart';

abstract class AppConfigInteractor {
  Future<Pagination<AppConfig>> getAllSystemConfigs();
  Future<AppConfig> getSystemConfigByKey(String key);
  Future<AppConfig> getSystemAppVersion();
}

final class AppConfigInteractorImpl implements AppConfigInteractor {
  AppConfigInteractorImpl({required AppConfigRepository repository})
    : _repository = repository;

  final AppConfigRepository _repository;

  @override
  Future<Pagination<AppConfig>> getAllSystemConfigs() {
    return _repository.getAllAppConfigs();
  }

  @override
  Future<AppConfig> getSystemConfigByKey(String key) {
    return _repository.getAppConfigByKey(key);
  }

  @override
  Future<AppConfig> getSystemAppVersion() {
    return _repository.getAppVersion();
  }
}
