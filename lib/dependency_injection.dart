import 'package:app_core/app_core.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:v_clean_architecture/app/app_environment.dart';
import 'package:v_clean_architecture/constants/constants.dart';
import 'package:v_clean_architecture/data/data.dart';
import 'package:v_clean_architecture/domain/domain.dart';
import 'package:v_clean_architecture/domain/repositories/repositories.dart';

final class DI {
  // Always returns the same DI instance
  factory DI() => it;
  // Private constructor (singleton pattern)
  DI._() {
    _getIt = GetIt.instance;
  }
  // Holds the GetIt instance
  late GetIt _getIt;

  // Singleton instance
  static final DI it = DI._();

  T get<T extends Object>({String? instanceName}) =>
      _getIt<T>(instanceName: instanceName);

  void initialize() {
    _registerHttpClients();
    _registerLocalSources();
    _registerLocalDatabase();
    _registerRemoteSources();
    _registerRepositories();
    _registerInteractors();
  }

  AuthTokens? authTokens;

  void _registerHttpClients() {
    // HTTP CLIENTS ------------------------------------------------------------
    final talker = TalkerFlutter.init();
    final dioLoggerInterceptor = TalkerDioLogger(
      talker: talker,
      settings: const TalkerDioLoggerSettings(printRequestHeaders: true),
    );
    // final certPinningInterceptor = CertificatePinningInterceptor(
    //   allowedSHAFingerprints: AppEnvironment.certPinning,
    // );
    final defaultHeaders = {
      HttpConstants.contentType: HttpConstants.jsonContentType,
      HttpConstants.xAppId: AppEnvironment.xAppId,
    };

    _getIt
      ..registerSingleton<AuthInterceptor>(
        AuthInterceptor(
          getAuthRepository: () => get<AuthRepository>(),
          getAuthTokens: () => authTokens,
          retryInterceptors: [
            // if (!AppEnvironment.ignoreSSL)
            //   CertificatePinningInterceptor(
            //     allowedSHAFingerprints: AppEnvironment.certPinning,
            //   ),
            dioLoggerInterceptor,
          ],
        ),
      )
      ..registerSingleton<BaseHttpClient>(
        DioClient(
          Dio(),
          host: AppEnvironment.host,
          headers: defaultHeaders,
          interceptors: [
            // if (!AppEnvironment.ignoreSSL) certPinningInterceptor,
            get<AuthInterceptor>(),
            dioLoggerInterceptor,
          ],
        ),
        instanceName: HttpConstants.host1ServiceKey,
      )
      ..registerSingleton<BaseHttpClient>(
        DioClient(
          Dio(),
          host: AppEnvironment.host2,
          headers: defaultHeaders,
          interceptors: [
            // if (!AppEnvironment.ignoreSSL) certPinningInterceptor,
            get<AuthInterceptor>(),
            dioLoggerInterceptor,
          ],
        ),
        instanceName: HttpConstants.host2ServiceKey,
      );
  }

  void _registerLocalSources() {
    // LOCAL STORAGE -----------------------------------------------------------
    _getIt
      ..registerLazySingleton<LocalStorage>(() => SecureLocalStorage()..setup())
      ..registerFactory<AuthLocalStorage>(
        () => AuthLocalStorageImpl(localStorage: get<LocalStorage>()),
      )
      ..registerFactory<UserLocalStorage>(
        () => UserLocalStorageImpl(localStorage: get<LocalStorage>()),
      );
  }

  void _registerLocalDatabase() {
    // LOCAL DATABASE ----------------------------------------------------------
  }

  void _registerRemoteSources() {
    // REMOTE SOURCE -----------------------------------------------------------
    _getIt
      ..registerFactory<AuthRemoteSource>(
        () => AuthRemoteSourceImpl(
          identityClient: get<BaseHttpClient>(
            instanceName: HttpConstants.host1ServiceKey,
          ),
        ),
      )
      ..registerFactory<FileRemoteSource>(
        () => FileRemoteSourceImpl(
          client: get<BaseHttpClient>(
            instanceName: HttpConstants.host2ServiceKey,
          ),
          localStorage: get<LocalStorage>(),
        ),
      )
      ..registerFactory<UserRemoteSource>(
        () => UserRemoteSourceImpl(
          host1Client: get<BaseHttpClient>(
            instanceName: HttpConstants.host1ServiceKey,
          ),
          host2Client: get<BaseHttpClient>(
            instanceName: HttpConstants.host2ServiceKey,
          ),
        ),
      )
      ..registerFactory<AppConfigRemoteSource>(
        () => AppConfigRemoteSourceImpl(
          client: get<BaseHttpClient>(
            instanceName: HttpConstants.host1ServiceKey,
          ),
        ),
      );
  }

  void _registerRepositories() {
    // REPOSITORIES ----------------------------------------------------------
    _getIt
      ..registerFactory<AuthRepository>(
        () => AuthRepositoryImpl(
          authRemoteSource: get<AuthRemoteSource>(),
          authLocalStorage: get<AuthLocalStorage>(),
          googleSignIn: GoogleSignIn.instance,
          onAuthTokensChanged: (value) => authTokens = value,
        ),
      )
      ..registerFactory<UserRepository>(
        () => UserRepositoryImpl(
          localStorage: get<UserLocalStorage>(),
          remoteSource: get<UserRemoteSource>(),
          authLocalStorage: get<AuthLocalStorage>(),
        ),
      )
      ..registerFactory<FileRepository>(
        () => FileRepositoryImpl(remoteSource: get<FileRemoteSource>()),
      )
      ..registerFactory<AppConfigRepository>(
        () =>
            AppConfigRepositoryImpl(remoteSource: get<AppConfigRemoteSource>()),
      );
  }

  Future<void> _registerInteractors() async {
    // INTERACTORS -----------------------------------------------------------
    _getIt
      ..registerFactory<AuthInteractor>(
        () => AuthInteractorImpl(
          repository: get<AuthRepository>(),
        ),
      )
      ..registerFactory<UserInteractor>(
        () => UserInteractorImpl(repository: get<UserRepository>()),
      )
      ..registerFactory<AppConfigInteractor>(
        () => AppConfigInteractorImpl(repository: get<AppConfigRepository>()),
      );
  }
}
