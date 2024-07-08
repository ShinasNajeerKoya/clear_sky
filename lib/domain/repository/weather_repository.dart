import 'dart:convert';

import 'package:clear_sky/data/models/geo_data_model.dart';
import 'package:clear_sky/data/models/weather_data_model.dart';
import 'package:clear_sky/data/services/weather_service.dart';

class WeatherRepository {
  final WeatherService weatherService;

    WeatherRepository(this.weatherService);

  Future<GeoData?> getGeoData(String cityName) async {
    GeoData? geoData;

    try {
      var response = await weatherService.getGeoData(cityName);
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        if (body is List<dynamic> && body.isNotEmpty) {
          geoData = GeoData.fromJson(body);
        }
      }
    } catch (errorFound) {
      rethrow;
    }

    return geoData;
  }

  Future<WeatherData?> getWeatherData(GeoData geoData) async {
    WeatherData? weatherData;
    try {
      var response = await weatherService.getWeatherData(latitude: geoData.lat, longitude: geoData.lon);
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);

        if (body is Map<String, dynamic>) {
          weatherData = WeatherData.fromJson(body);

        }
      }
    } catch (errorFound) {
      rethrow;
    }
    return weatherData;
  }
}
