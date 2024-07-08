import 'package:bloc_test/bloc_test.dart';
import 'package:clear_sky/config/base_state/base_state.dart';
import 'package:clear_sky/data/models/geo_data_model.dart';
import 'package:clear_sky/data/models/weather_data_model.dart';
import 'package:clear_sky/domain/repository/weather_repository.dart';
import 'package:clear_sky/domain/use_cases/weather_use_case.dart';
import 'package:clear_sky/presentation/features/home/bloc/weather_bloc/weather_bloc.dart';
import 'package:clear_sky/presentation/features/home/bloc/weather_bloc/weather_event.dart';
import 'package:clear_sky/presentation/features/home/bloc/weather_bloc/weather_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockWeatherRepository extends Mock implements WeatherRepository {}

void main() {
  WeatherUseCase? weatherUseCase;
  final mockWeatherRepository = MockWeatherRepository();

  setUpAll(() {
    // first notedown the response for geoData and weatherData from api
    registerFallbackValue(GeoData(lat: 0.0, lon: 0.0));
    registerFallbackValue(WeatherData(base: "stations"));
  });

  setUp(() {
    weatherUseCase = WeatherUseCase(mockWeatherRepository);
  });

  final geoData = GeoData(lat: 10.0, lon: 10.0);
  final weatherData = WeatherData(base: "stations");

  when(() => mockWeatherRepository.getGeoData("italy")).thenAnswer((_) async => geoData);

  when(() => mockWeatherRepository.getWeatherData(geoData)).thenAnswer((_) async => weatherData);

  blocTest<WeatherBloc, WeatherState>(
    'Successful Data Received : emitting loading and success state when the event is added and response is success',
    build: () {
      return WeatherBloc(weatherUseCase!);
    },
    //adding event here
    act: (bloc) => bloc.add(const GetCityNameEvent("italy")),
    expect: () => [
      WeatherState.initial().copyWith(weatherData: null, error: null)..dataState = DataState.loading,
      WeatherState.initial().copyWith(weatherData: weatherData, error: null)..dataState = DataState.success,
    ],
  );

  blocTest<WeatherBloc, WeatherState>(
    'Error Caught : emitting loading and error state when the event is added and response is error',
    build: () {
      when(() => mockWeatherRepository.getGeoData("italy")).thenThrow(Exception("Failed to fetch data"));
      return WeatherBloc(weatherUseCase!);
    },
    act: (bloc) => bloc.add(const GetCityNameEvent("italy")),
    expect: () => [
      WeatherState.initial().copyWith(weatherData: null, error: null)..dataState = DataState.loading,
      WeatherState.initial().copyWith(weatherData: null, error: "Exception: Failed to fetch data")
        ..dataState = DataState.error,
    ],
  );
}
