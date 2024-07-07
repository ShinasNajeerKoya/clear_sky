import 'package:clear_sky/data/models/geo_data_model.dart';
import 'package:clear_sky/data/models/weather_data_model.dart';
import 'package:clear_sky/domain/repository/weather_repository.dart';

class WeatherUseCase {
  final WeatherRepository weatherRepository;

  WeatherUseCase(this.weatherRepository);

  Future<WeatherData?> apiCall(String cityName) async {
    WeatherData? weatherData;
    try {
      final GeoData? geoData = await weatherRepository.getGeoData(cityName);
      if (geoData != null) {
        weatherData = await weatherRepository.getWeatherData(geoData);
      }
    } catch (errorFound) {
      rethrow;
    }
    return weatherData;
  }
}
