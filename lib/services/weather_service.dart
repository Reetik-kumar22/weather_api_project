import 'dart:convert';

import 'package:working_with_api/models/weather_modal.dart';
import 'package:http/http.dart' as http;

class WeatherService {
   // content values {api key, URL, const objs};



 final String baseUrl = "https://api.openweathermap.org/data/2.5";
 final String apiId = "2bef5e516b48ded3c5c3964100a23d09";
  //function
  Future<WeatherModal?> getWeatherData(String cityName) async {
    //url, response json, conditionaly data fetch (status == 200)
   try{
   String url =
       "$baseUrl/weather?q=$cityName&appid=$apiId&units=metric";

   http.Response response = await  http.get(Uri.parse(url));

   if(response.statusCode == 200){
     Map<String,dynamic> jsonData =
     jsonDecode(response.body) as Map<String,dynamic>;

     return WeatherModal.fromJson(jsonData);
   } else {
     print("failed here");
     throw Exception("Failed to load the data");
   }
   } catch (e){
     print("failed here $e");
     throw Exception("Error: $e");
   }
    // Stop video in http package
  }
}