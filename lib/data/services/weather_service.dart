import 'package:clear_sky/constants/api_endpoint/api_endpoints.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  Future<http.Response> getGeoData(String cityName) async {
    String url = "$baseUrl/geo/1.0/direct?q=$cityName&limit-=1&appid=$API_KEY";

    return await http.get(Uri.parse(url));
  }

  Future<http.Response> getWeatherData({double? latitude, double? longitude}) async {
    String url = "$baseUrl/data/2.5/weather?lat=$latitude&lon=$longitude&units=metric&appid=$API_KEY";

    return await http.get(Uri.parse(url));
  }
}
