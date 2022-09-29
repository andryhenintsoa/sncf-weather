import 'package:sncf_weather/core/model/user.dart';

import '../../util/constants.dart';
import '../exception/main_exception.dart';

class UserApi {

  Future<Map<String, dynamic>?> login(email, password) async {

    await Future.delayed(const Duration(seconds: 1));

    if(password == "0000"){
      return User(id: 0, username: email).toJson();
    }

    for(Map<String,dynamic> user in users){
      if(user["email"] == email && user["password"] == password){
        return user;
      }
    }

    throw MainException("Email et/ou mot de passe invalide");
  }
}
