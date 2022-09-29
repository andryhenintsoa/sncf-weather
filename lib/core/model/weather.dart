import 'package:json_annotation/json_annotation.dart';

import '../../util/utils.dart';
import 'city.dart';
import 'weather_human_data.dart';
import 'weather_precise_data.dart';

part 'weather.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class Weather {
  final List<WeatherHumanData> weather;
  final WeatherPreciseData main;
  final DateTime dtTxt;
  final int dt;
  final City city;

  Weather(this.weather, this.main, this.dtTxt, this.dt, this.city);

  factory Weather.fromJson(Map<String, dynamic> json) =>
      _$WeatherFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherToJson(this);

  DateTime get dateTime =>
      (DateTime.fromMillisecondsSinceEpoch(dt * 1000, isUtc: true));

  DateTime get cityDateTime => dateTime.add(Duration(seconds: city.timezone));

  String get dateTimeHumanDescription {
    String desc = dateTimeFormatDisplay.format(cityDateTime);
    if (city.timezone != dateTime.toLocal().timeZoneOffset.inSeconds) {
      desc += " (${onlyTimeFormatDisplay.format(dateTime.toLocal())} ici)";
    }
    return desc;
  }
}
