import 'package:working_with_api/models/main_weatherdata.dart';

class WeatherCondition {
  final String main;
  final String description;

  WeatherCondition ({
    required this.main,
    required this.description
  });

 WeatherCondition.fromJson(Map<String,dynamic> json)
  : main = json['weather'][0]['main'],
  description = json['weather'][0]['description'];
}