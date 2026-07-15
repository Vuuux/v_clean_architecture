import 'package:v_clean_architecture/domain/entities/entities.dart';

abstract class AppConfigRepository {
  Future<Pagination<AppConfig>> getAllAppConfigs();
  Future<AppConfig> getAppConfigByKey(String key);
  Future<AppConfig> getAppVersion();
}
