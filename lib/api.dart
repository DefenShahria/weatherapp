import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherInfo {
  String cityName;
  double temperature;
  double minimumtmp;
  double maximumtmp;
  String icon;

  WeatherInfo({
    required this.cityName,
    required this.temperature,
    required this.icon,
    required this.maximumtmp,
    required this.minimumtmp,

  });

  factory WeatherInfo.fromJson(Map<String, dynamic> json) {
    return WeatherInfo(
      cityName: json["name"],
      temperature: json["main"]["temp"],
      maximumtmp: json['main']['temp_max'],
      minimumtmp: json['main']['temp_min'],
      icon: json['weather'][0]['icon'],


    );
  }

  static Future<WeatherInfo> fetchWeatherInfo(String city) async {
    final apiKey = 'a6ccb95015036c1804fbff47a1c57e35';
    final apiUrl =
        'https://api.openweathermap.org/data/2.5/weather?q=London&appid=$apiKey&units=metric';

    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      var ab= WeatherInfo.fromJson(jsonData);
      print(ab.temperature);
      return ab;
    } else {
      throw Exception('Failed to fetch weather data');
    }
  }

}

