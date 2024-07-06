part of 'weather_bloc.dart';

class WeatherState extends Equatable {
  final bool isLoading;
  final WeatherData? weatherData;
  final String? error;

  const WeatherState({required this.isLoading, this.weatherData, this.error});

  factory WeatherState.initial() {
    return WeatherState(isLoading: false, weatherData: null, error: null);
  }

  @override
  List<Object?> get props => [isLoading, weatherData, error];

  @override
  String toString() {
    return 'WeatherState{isLoading: $isLoading, weatherData: $weatherData, error: $error}';
  }

  WeatherState copyWith({
    bool? isLoading,
    WeatherData? weatherData,
    String? error,
  }) {
    return WeatherState(
      isLoading: isLoading ?? this.isLoading,
      weatherData: weatherData ?? this.weatherData,
      error: error ?? this.error,
    );
  }
}
