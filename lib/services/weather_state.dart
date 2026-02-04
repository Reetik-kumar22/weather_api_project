import 'package:working_with_api/models/weather_modal.dart';

class WeatherState {
  final bool isLoading;
  final String errorMessage;
  final WeatherModal? weather;

  WeatherState({
    this.isLoading = false,
    this.errorMessage = '',
    this.weather
  });



  WeatherState copyWith({
    bool? isLoading,
    String? eMessage,
    WeatherModal? weather,
  }){
    return WeatherState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: eMessage ?? this.errorMessage,
      weather: weather,
    );
  }
}