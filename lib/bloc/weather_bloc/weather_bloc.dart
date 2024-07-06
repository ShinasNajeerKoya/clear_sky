import 'package:clear_sky/models/weather_data_model.dart';
import 'package:clear_sky/repo/weather_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherState.initial()) {
    on<GetCityNameEvent>((event, emit) async {
      emit(state.copyWith(isLoading: true, weatherData: null, error: null));

      try {
        WeatherData weatherData = await WeatherRepo.apiCall(event.cityName);
        emit(state.copyWith(isLoading: false, weatherData: weatherData));
      } catch (error) {
        emit(state.copyWith(isLoading: false, error: error.toString()));
      }
    });
  }
}
