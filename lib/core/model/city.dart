import 'package:json_annotation/json_annotation.dart';

part 'city.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class City {
  final int timezone;

  City(this.timezone);

  factory City.fromJson(Map<String, dynamic> json) =>
      _$CityFromJson(json);

  Map<String, dynamic> toJson() => _$CityToJson(this);
}
