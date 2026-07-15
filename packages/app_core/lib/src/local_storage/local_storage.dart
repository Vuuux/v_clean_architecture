abstract class LocalStorage {
  Future<void> setInt(
    String key,
    int value, {
    bool shouldEncrypt = false,
  });
  Future<int?> getInt(
    String key, {
    bool shouldDecrypt = false,
  });
  Future<void> setDouble(
    String key,
    double value, {
    bool shouldEncrypt = false,
  });
  Future<double?> getDouble(
    String key, {
    bool shouldDecrypt = false,
  });
  Future<void> setString(
    String key,
    String value, {
    bool shouldEncrypt = false,
  });
  Future<String?> getString(
    String key, {
    bool shouldDecrypt = false,
  });
  Future<void> setBool(
    String key,
    bool value, {
    bool shouldEncrypt = false,
  });
  Future<bool?> getBool(
    String key, {
    bool shouldDecrypt = false,
  });
  Future<Map<String, String>> getAll();
  Future<void> delete({required String key});
  Future<void> deleteAll();
}
