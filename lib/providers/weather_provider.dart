
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:working_with_api/services/weather_service.dart';
import 'package:working_with_api/services/weather_state.dart';


class WeatherNotifier extends StateNotifier<WeatherState>{
  WeatherNotifier() : super(WeatherState());

  final WeatherService _weatherService = WeatherService();
  Future<void> getWeather(String cityName) async {
    //function data fetch
    if(cityName.trim().isEmpty){
      state = state.copyWith(
        eMessage: "Please enter the city name",
        weather: null,
      );
      return;
    }
    //set loading state
    state = state.copyWith(
      isLoading: true,
      eMessage: '',
      weather: null,
    );

    //logic to get data
    try{
      final weather = await _weatherService.getWeatherData(cityName);
      print(weather!.condition);
      state = state.copyWith(
        isLoading: false,
        eMessage: '',
        weather: weather,
      );
    }catch(e){
        state = state.copyWith(
          isLoading: false,
          weather: null,
          eMessage: e.toString(),
        );
    }
  }
}


final weatherProvider = StateNotifierProvider<WeatherNotifier, WeatherState>(
    (ref) => WeatherNotifier(),
);