import 'package:clear_sky/data/services/weather_service.dart';
import 'package:clear_sky/domain/repository/weather_repository.dart';

WeatherRepository provideWeatherRepository() {
  return WeatherRepository(WeatherService());
}
