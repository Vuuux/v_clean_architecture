import 'dart:io';

import 'package:app_core/app_core.dart';
import 'package:v_clean_architecture/domain/entities/entities.dart';

class _AppConfigKeys {
  static const String minAndroidAppVersion = 'android_min_version';
  static const String minIosAppVersion = 'ios_min_version';
}

class _AppConfigApi {
  static const String baseSystemConfig = '/v1/system-config';
}

abstract class AppConfigRemoteSource {
  Future<Pagination<AppConfig>> getAllAppConfigs();
  Future<AppConfig> getAppConfigByKey(String key);
  Future<AppConfig> getAppVersion();
}

final class AppConfigRemoteSourceImpl implements AppConfigRemoteSource {
  AppConfigRemoteSourceImpl({required BaseHttpClient client})
    : _client = client;

  final BaseHttpClient _client;

  @override
  Future<Pagination<AppConfig>> getAllAppConfigs() async {
    final response = await _client.get(_AppConfigApi.baseSystemConfig);

    final jsonResponse = PaginationResponse<AppConfig>.fromJson(
      response as Map<String, dynamic>,
      (item) => AppConfig.fromJson(item! as Map<String, dynamic>),
    );

    return Pagination(
      data: jsonResponse.data,
      page: jsonResponse.page,
      total: jsonResponse.total,
      totalPages: jsonResponse.totalPages,
    );
  }

  @override
  Future<AppConfig> getAppConfigByKey(String key) async {
    final response = await _client.get(
      _AppConfigApi.baseSystemConfig,
      params: {
        'search_key': key,
      },
    );

    return AppConfig.fromJson(response as Map<String, dynamic>);
  }

  @override
  Future<AppConfig> getAppVersion() async {
    final key = Platform.isIOS
        ? _AppConfigKeys.minIosAppVersion
        : _AppConfigKeys.minAndroidAppVersion;

    final response = await _client.get(
      _AppConfigApi.baseSystemConfig,
      params: {
        'search_key': key,
      },
    );

    return AppConfig.fromJson(response['data'][0] as Map<String, dynamic>);
  }
}
