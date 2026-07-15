// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'local_storage.dart';

final class SecureLocalStorage implements LocalStorage {
  SecureLocalStorage() {
    const androidOptions = AndroidOptions(encryptedSharedPreferences: true);
    _storage = const FlutterSecureStorage(
      iOptions: IOSOptions(accessibility: KeychainAccessibility.passcode),
      aOptions: androidOptions,
    );
  }
  late final FlutterSecureStorage _storage;
  late Completer<void> _setupCompleter;
  bool _isSetupCompleted = false;

  Future<void> setup() async {
    _setupCompleter = Completer();
    const firstRunKey = 'is_first_run';
    final pref = await SharedPreferences.getInstance();
    final isFirstRun = pref.getBool(firstRunKey) ?? true;
    if (isFirstRun) {
      await deleteAll();
      await pref.setBool(firstRunKey, false);
    }
    _setupCompleter.complete();
    _isSetupCompleted = true;
  }

  Future<void> _waitForSetupCompleted() async {
    if (_isSetupCompleted) {
      return;
    }
    await _setupCompleter.future;
  }

  String _encrypt(String data) {
    final bytes = utf8.encode(data);
    return base64.encode(bytes);
  }

  String _decrypt(String base64Data) {
    final bytes = base64.decode(base64Data);
    return utf8.decode(bytes);
  }

  Future<String?> _getValueAndDecryptIfNeeded({
    required String key,
    required bool shouldDecrypt,
  }) async {
    await _waitForSetupCompleted();
    final value = await _storage.read(key: key);
    if (value != null && shouldDecrypt) {
      return _decrypt(value);
    }
    return value;
  }

  @override
  Future<void> setInt(
    String key,
    int value, {
    bool shouldEncrypt = false,
  }) async {
    var data = value.toString();
    if (shouldEncrypt) {
      data = _encrypt(data);
    }
    return _storage.write(key: key, value: data);
  }

  @override
  Future<int?> getInt(String key, {bool shouldDecrypt = false}) async {
    final value = await _getValueAndDecryptIfNeeded(
      key: key,
      shouldDecrypt: shouldDecrypt,
    );
    if (value == null) {
      return null;
    }
    return int.tryParse(value);
  }

  @override
  Future<void> setDouble(
    String key,
    double value, {
    bool shouldEncrypt = false,
  }) async {
    var data = value.toString();
    if (shouldEncrypt) {
      data = _encrypt(data);
    }
    return _storage.write(key: key, value: data);
  }

  @override
  Future<double?> getDouble(String key, {bool shouldDecrypt = false}) async {
    final value = await _getValueAndDecryptIfNeeded(
      key: key,
      shouldDecrypt: shouldDecrypt,
    );
    if (value == null) {
      return null;
    }
    return double.tryParse(value);
  }

  @override
  Future<void> setString(
    String key,
    String value, {
    bool shouldEncrypt = false,
  }) async {
    var data = value;
    if (shouldEncrypt) {
      data = _encrypt(data);
    }
    return _storage.write(key: key, value: data);
  }

  @override
  Future<String?> getString(String key, {bool shouldDecrypt = false}) async {
    final value = await _getValueAndDecryptIfNeeded(
      key: key,
      shouldDecrypt: shouldDecrypt,
    );
    return value;
  }

  @override
  Future<void> setBool(
    String key,
    bool value, {
    bool shouldEncrypt = false,
  }) async {
    var data = value.toString();
    if (shouldEncrypt) {
      data = _encrypt(data);
    }
    return _storage.write(key: key, value: data);
  }

  @override
  Future<bool?> getBool(String key, {bool shouldDecrypt = false}) async {
    final value = await _getValueAndDecryptIfNeeded(
      key: key,
      shouldDecrypt: shouldDecrypt,
    );
    if (value == null) {
      return null;
    }

    return value.toLowerCase() == 'true';
  }

  @override
  Future<Map<String, String>> getAll() {
    return _storage.readAll();
  }

  @override
  Future<void> delete({required String key}) {
    return _storage.delete(key: key);
  }

  @override
  Future<void> deleteAll() {
    return _storage.deleteAll();
  }
}
