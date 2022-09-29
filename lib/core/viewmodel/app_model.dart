import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../base_model.dart';
import '../enum/view_state.dart';
import '../model/user.dart';
import '../service/authentification_service.dart';
import '../service/storage_service.dart';
import '../service_locator.dart';

class AppModel extends BaseModel {
  Future initData() async {
    setState(ViewState.busy);

    debugPrint("initData begin");

    await Future.wait(
      [
        Future.delayed(const Duration(seconds: 2)),
        loadStoredUser(),
      ],
    );
    debugPrint("initData done");
    setState(ViewState.idle);
  }

  Future loadStoredUser() async {
    var prefs = await StorageService.getInstance();

    int? id = prefs.getInt("id");
    String? username = prefs.getString("username");
    String? token = prefs.getString("token");

    if ([id, username, token].every((e) => e!=null)) {
      final user = User(
        id: id!,
        username: username!,
      );

      locator<AuthenticationService>().token = token!;

      locator<AuthenticationService>().userController.add(user);
    }
  }

  void logout(){
    locator<AuthenticationService>().logout();
  }
}
