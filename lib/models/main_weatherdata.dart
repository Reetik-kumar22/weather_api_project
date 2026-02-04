
class MainWeatherData {
  final double temperature;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final int pressure;
  final int humidity;

  MainWeatherData({
    required this.temperature,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.humidity
  });

  MainWeatherData.fromJson(Map<String , dynamic> json)
      : temperature = json['main']['temp'].toDouble(),
        feelsLike = json['main']['feels_like'].toDouble(),
        tempMin = json['main']['temp_min'].toDouble(),
        tempMax = json['main']['temp_max'].toDouble(),
        pressure = json['main']['pressure'],
        humidity = json['main']['humidity'];


}