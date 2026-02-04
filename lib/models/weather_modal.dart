import 'package:working_with_api/models/main_weatherdata.dart';
import 'package:working_with_api/models/weather_condition.dart';

class WeatherModal {
  final String cityName;
  final String countryName;
  final WeatherCondition condition;
  final MainWeatherData main;


  WeatherModal({
    required this.cityName,
    required this.countryName,
    required this.condition,
    required this.main
  });

  WeatherModal.fromJson(Map<String, dynamic> json)
      : cityName = json['name'],
      countryName = json ['sys']['country'],
      condition = WeatherCondition.fromJson(json),
      main = MainWeatherData.fromJson(json);
}