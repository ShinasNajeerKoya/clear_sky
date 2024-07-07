import 'package:clear_sky/config/repository_provider/repository_provider.dart';
import 'package:clear_sky/domain/use_cases/weather_use_case.dart';
import 'package:clear_sky/presentation/features/home/bloc/weather_bloc/weather_bloc.dart';

WeatherBloc provideWeatherBloc() {
  return WeatherBloc(
    WeatherUseCase(provideWeatherRepository()),
  );
}
