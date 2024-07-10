import 'package:clear_sky/domain/repository/weather_repository.dart';
import 'package:clear_sky/domain/use_cases/weather_use_case.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';

@GenerateMocks(
  [
    WeatherRepository,
    WeatherUseCase,
  ],
  customMocks: [MockSpec<http.Client>(as: #MockHttpClient)],
)
void main() {}
