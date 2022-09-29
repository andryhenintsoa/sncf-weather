

import 'package:flutter/material.dart';

import '../base_model.dart';
import '../enum/view_state.dart';
import '../exception/main_exception.dart';
import '../model/weather.dart';
import '../service/storage_service.dart';
import '../service/weather_api.dart';
import '../service_locator.dart';

class WeatherModel extends BaseModel {
  final WeatherApi _api = locator<WeatherApi>();

  List<Weather> weathers = [];
  String city = "";

  String? errorMessage;
  bool needToShowError = false;

  Future getWeathers({String? newCity, VoidCallback? onSuccess}) async {
    setState(ViewState.busy);
    _setError(null);

    weathers = [];

    final prefs = await StorageService.getInstance();

    city = newCity ??
        (prefs.getString("city")) ??
        "Paris";
    city = city.trim().toUpperCase();

    prefs.setString("city", city);

    await Future.delayed(const Duration(seconds: 2));

    _api.getWeathers(city).then((result) {
      weathers.addAll(result);
      onSuccess?.call();
      setState(ViewState.idle);
    }).catchError((dynamic e, StackTrace trace) {
      String message =
          e is MainException ? e.message : "Une erreur s'est produite";

      _setError(message);
      setState(ViewState.idle);
    });
  }

  _setError(String? message) {
    needToShowError = (message != null);
    errorMessage = message;
  }
}
