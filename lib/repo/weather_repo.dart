import 'dart:convert';

import 'package:clear_sky/constants/api_endpoint/api_endpoints.dart';
import 'package:clear_sky/models/geo_data_model.dart';
import 'package:clear_sky/models/weather_data_model.dart';
import 'package:http/http.dart' as http;

class WeatherRepo {
  static Future<GeoData> getGeoData(String cityName) async {
    String url = "$baseUrl/geo/1.0/direct?q=$cityName&limit-=1&appid=$API_KEY";

    try {
      var response = await http.get(Uri.parse(url));
      GeoData geoData = GeoData.fromJson(jsonDecode(response.body));
      return geoData;
    } catch (errorFound) {
      rethrow;
    }
  }

  static Future<WeatherData> getWeatherData(GeoData geoData) async {
    String url =
        "$baseUrl/data/2.5/weather?lat=${geoData.lat}&lon=${geoData.lon}&units=metric&appid=$API_KEY";

    try {
      var response = await http.get(Uri.parse(url));
      WeatherData weatherData = WeatherData.fromJson(jsonDecode(response.body));
      return weatherData;
    } catch (errorFound) {
      rethrow;
    }
  }

  static Future<WeatherData> apiCall(String cityName) async {
    try {
      final GeoData geoData = await getGeoData(cityName);
      final WeatherData weatherData = await getWeatherData(geoData);
      return weatherData;
    } catch (errorFound) {
      rethrow;
    }
  }
}
