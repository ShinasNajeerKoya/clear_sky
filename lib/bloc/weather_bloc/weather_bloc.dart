import 'package:clear_sky/models/weather_data_model.dart';
import 'package:clear_sky/repo/weather_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherState.initial()) {
    on<GetCityNameEvent>(_onGetCityNameEvent);
    on<FetchSearchResultsEvent>(_onFetchSearchResultsEvent);
    on<FetchCityNameFromPopularEvent>(_onFetchCityNameFromPopularEvent);
  }

  void _onGetCityNameEvent(GetCityNameEvent event, Emitter<WeatherState> emit) async {
    emit(state.copyWith(isLoading: true, weatherData: null, error: null));

    try {
      WeatherData weatherData = await WeatherRepo.apiCall(event.cityName);
      emit(state.copyWith(isLoading: false, weatherData: weatherData));
    } catch (error) {
      emit(state.copyWith(isLoading: false, error: error.toString()));
    }
  }

  void _onFetchSearchResultsEvent(FetchSearchResultsEvent event, Emitter<WeatherState> emit) async {
    emit(state.copyWith(isLoading: true, weatherData: null, error: null));

    try {
      WeatherData weatherData = await WeatherRepo.apiCall(event.searchValue);
      emit(state.copyWith(isLoading: false, weatherData: weatherData));
    } catch (error) {
      emit(state.copyWith(isLoading: false, error: error.toString()));
    }
  }

  void _onFetchCityNameFromPopularEvent(
      FetchCityNameFromPopularEvent event, Emitter<WeatherState> emit) async {
    emit(state.copyWith(isLoading: true, weatherData: null, error: null));

    try {
      WeatherData weatherData = await WeatherRepo.apiCall(event.popularCityName);
      emit(state.copyWith(isLoading: false, weatherData: weatherData));
    } catch (error) {
      emit(state.copyWith(isLoading: false, error: error.toString()));
    }
  }
}
