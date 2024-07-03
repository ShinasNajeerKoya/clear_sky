part of 'weather_bloc.dart';

enum WeatherStatus {
  initial,
  loading,
  loaded,
  error,
}

class WeatherState extends Equatable {
  final WeatherStatus weatherStatus;
  final WeatherData weatherData;
  final String error;

  const WeatherState({required this.weatherStatus, required this.weatherData, required this.error});

  factory WeatherState.initial() {
    return WeatherState(weatherStatus: WeatherStatus.initial, weatherData: WeatherData(), error: "");
  }

  @override
  List<Object> get props => [weatherStatus, weatherData, error];

  @override
  String toString() {
    return 'WeatherState{weatherStatus: $weatherStatus, weatherData: $weatherData, error: $error}';
  }

  WeatherState copyWith({
    WeatherStatus? weatherStatus,
    WeatherData? weatherData,
    String? error,
  }) {
    return WeatherState(
      weatherStatus: weatherStatus ?? this.weatherStatus,
      weatherData: weatherData ?? this.weatherData,
      error: error ?? this.error,
    );
  }
}
