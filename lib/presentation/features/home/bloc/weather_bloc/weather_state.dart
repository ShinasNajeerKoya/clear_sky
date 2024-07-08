import 'package:clear_sky/config/base_state/base_state.dart';
import 'package:clear_sky/data/models/weather_data_model.dart';
import 'package:equatable/equatable.dart';

class WeatherState extends BaseState with EquatableMixin {
  final WeatherData? weatherData;
  final String? error;

  WeatherState({this.weatherData, this.error});

  factory WeatherState.initial() {
    return WeatherState(weatherData: null, error: null);
  }

  WeatherState copyWith({
    WeatherData? weatherData,
    String? error,
  }) {
    return WeatherState(
      weatherData: weatherData ?? this.weatherData,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [weatherData, error, dataState];
}
