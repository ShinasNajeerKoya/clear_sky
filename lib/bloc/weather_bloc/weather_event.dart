part of 'weather_bloc.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();
}

class GetCityNameEvent extends WeatherEvent {
  final String cityName;

  const GetCityNameEvent(this.cityName);

  @override
  List<Object> get props => [cityName];
}
