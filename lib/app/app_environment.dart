class AppEnvironment {
  AppEnvironment._();

  static String mediaHost = const String.fromEnvironment('MEDIA_HOST');
  static String host = const String.fromEnvironment('HOST');
  static String host2 = const String.fromEnvironment('HOST2');
  static String triggerDeeplinkUrl = const String.fromEnvironment(
    'TRIGGER_DEEPLINK_URL',
  );
  static String xAppId = const String.fromEnvironment('X_APP_ID');
  static String videoCookie = const String.fromEnvironment('VIDEO_COOKIE');

  static String playStoreAppId = const String.fromEnvironment(
    'PLAY_STORE_APP_ID',
  );
  static String appStoreAppId = const String.fromEnvironment(
    'APP_STORE_APP_ID',
  );

  static String clientId = const String.fromEnvironment('CLIENT_ID');
  static String googleIosClientId = const String.fromEnvironment(
    'GOOGLE_IOS_CLIENT_ID',
  );
  static String googleAndroidClientId = const String.fromEnvironment(
    'GOOGLE_ANDROID_CLIENT_ID',
  );
  static String googleSeverClientId = const String.fromEnvironment(
    'GOOGLE_SERVER_CLIENT_ID',
  );
  static String lineChannelId = const String.fromEnvironment('LINE_CHANNEL_ID');

  static String env = const String.fromEnvironment('BUILD_ENV');
  static bool ignoreSSL = const bool.fromEnvironment('IGNORE_SSL');
  static bool disableVKey = const bool.fromEnvironment('DISABLE_VKEY');
  static bool debugDownloader = const bool.fromEnvironment('DEBUG_DOWNLOADER');
  static bool blocLogEnabled = const bool.fromEnvironment('BLOC_LOG_ENABLED');
  static String fcmTopic = const String.fromEnvironment('FCM_TOPIC');

  static int downloadVideoValidDays = const int.fromEnvironment(
    'DOWNLOAD_VIDEO_VALID_DAYS',
  );

  static List<String> certPinning = _certPinningFromEnvironment();

  static List<String> _certPinningFromEnvironment() {
    const stringFromEnv = String.fromEnvironment('CERT_PINNING');

    if (stringFromEnv.length < 2) {
      return [stringFromEnv];
    }

    final data = stringFromEnv.substring(1, stringFromEnv.length - 1);
    return data.split(',');
  }
}
