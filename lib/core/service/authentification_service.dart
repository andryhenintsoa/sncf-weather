import 'dart:async';

import 'package:flutter/foundation.dart';

import '../model/user.dart';
import '../service_locator.dart';
import 'storage_service.dart';
import 'user_api.dart';

class AuthenticationService {
  final UserApi _api = locator<UserApi>();
  StreamController<User?> userController = StreamController<User?>();
  String? token;

  Future<bool> login(String email, String password) async {
    var result = await _api.login(email, password);

    if (result == null) {
      return false;
    }

    var user = User.fromJson(result);
    userController.add(user);

    token = user.username;

    await _setPersistentData(user: user);

    return true;
  }

  Future _setPersistentData({required User user}) async {
    final prefs = await StorageService.getInstance();

    prefs.setString('token', user.username);
    prefs.setString('username', user.username);
    prefs.setInt('id', user.id);
  }

  Future logout() async {
    debugPrint('Logout');
    token = null;
    final prefs = await StorageService.getInstance();
    [
      'token',
      'username',
      'id',
      'city',
    ].forEach((e) => prefs.remove(e));

    userController.add(null);
  }
}
