import 'package:json_annotation/json_annotation.dart';

part 'weather_human_data.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class WeatherHumanData {
  final int id;
  final String main;
  final String description;
  final String icon;

  WeatherHumanData(this.id, this.main, this.description, this.icon);

  factory WeatherHumanData.fromJson(Map<String, dynamic> json) =>
      _$WeatherHumanDataFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherHumanDataToJson(this);
}
