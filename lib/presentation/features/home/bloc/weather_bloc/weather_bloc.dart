import 'package:clear_sky/config/base_state/base_state.dart';
import 'package:clear_sky/data/models/weather_data_model.dart';
import 'package:clear_sky/domain/use_cases/weather_use_case.dart';
import 'package:clear_sky/presentation/features/home/bloc/weather_bloc/weather_event.dart';
import 'package:clear_sky/presentation/features/home/bloc/weather_bloc/weather_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  late WeatherUseCase weatherUseCase;

  WeatherBloc(this.weatherUseCase) : super(WeatherState.initial()) {
    on<GetCityNameEvent>(_onGetCityNameEvent);
    on<FetchSearchResultsEvent>(_onFetchSearchResultsEvent);
  }

  void _onGetCityNameEvent(GetCityNameEvent event, Emitter<WeatherState> emit) async {
    emit(state.copyWith(weatherData: null, error: null)..dataState = DataState.loading);

    try {
      WeatherData? weatherData = await weatherUseCase.apiCall(event.cityName);
      if (weatherData == null) {
        emit(state..dataState = DataState.error);
      } else {
        emit(state.copyWith(weatherData: weatherData)..dataState = DataState.success);
      }
    } catch (error) {
      emit(state.copyWith(error: error.toString())..dataState = DataState.error);
    }
  }

  void _onFetchSearchResultsEvent(FetchSearchResultsEvent event, Emitter<WeatherState> emit) async {
    emit(state.copyWith(weatherData: null, error: null)..dataState = DataState.loading);

    try {
      WeatherData? weatherData = await weatherUseCase.apiCall(event.searchValue);
      if (weatherData == null) {
        emit(state.copyWith()..dataState = DataState.error);
      } else {
        emit(state.copyWith(weatherData: weatherData)..dataState = DataState.success);
      }
    } catch (error) {
      emit(state.copyWith(error: error.toString())..dataState = DataState.error);
    }
  }
}
