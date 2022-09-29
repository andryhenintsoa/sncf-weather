import 'package:json_annotation/json_annotation.dart';

part 'weather_precise_data.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class WeatherPreciseData {
  final double temp;
  final double tempMax;
  final double tempMin;

  WeatherPreciseData(this.temp, this.tempMax, this.tempMin);

  factory WeatherPreciseData.fromJson(Map<String, dynamic> json) => _$WeatherPreciseDataFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherPreciseDataToJson(this);
}
