import 'package:get_it/get_it.dart';

import 'service/authentification_service.dart';
import 'service/user_api.dart';
import 'service/weather_api.dart';
import 'viewmodel/app_model.dart';
import 'viewmodel/login_model.dart';
import 'viewmodel/weather_model.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => UserApi());
  locator.registerLazySingleton(() => WeatherApi());
  locator.registerLazySingleton(() => AuthenticationService());

  locator.registerFactory(() => AppModel());
  locator.registerFactory(() => LoginModel());
  locator.registerFactory(() => WeatherModel());
}
