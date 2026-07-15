import 'dart:convert';

import 'package:app_core/app_core.dart';
import 'package:v_clean_architecture/constants/constants.dart';
import 'package:v_clean_architecture/domain/entities/entities.dart';

abstract class UserLocalStorage {
  Future<AppUser> getUserData();
  Future<void> setUserData(AppUser data);
}

final class UserLocalStorageImpl implements UserLocalStorage {
  UserLocalStorageImpl({required LocalStorage localStorage})
    : _localStorage = localStorage;

  final LocalStorage _localStorage;

  @override
  Future<AppUser> getUserData() async {
    final json = await _localStorage.getString(
      AppLocalStorageKey.userData,
    );
    if (json != null && json.isNotEmpty) {
      return jsonDecode(json) as AppUser;
    }
    return AppUser.empty();
  }

  @override
  Future<void> setUserData(
    AppUser data,
  ) async {
    final json = jsonEncode(data);
    await _localStorage.setString(AppLocalStorageKey.userData, json);
  }
}
