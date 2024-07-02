import 'dart:convert';
import 'dart:developer';

import 'package:clear_sky/constants/api_endpoints.dart';
import 'package:clear_sky/models/geo_data_model.dart';
import 'package:http/http.dart' as http;

class WeatherRepo {
  static void getGeoData() async {
    const String url = baseUrl + "/geo/1.0/direct?q=london&limit-=1&appid=" + API_KEY;
    var response = await http.get(Uri.parse(url));

    GeoData geoData = GeoData.fromJson(jsonDecode(response.body));

    print(geoData);
    log(response.body);
  }

  static void getWeatherData() async {
    const String url = baseUrl + "/data/2.5/weather?q=udupi&appid=" + API_KEY;
    var response = await http.get(Uri.parse(url));
    log(url);
    log(response.body);
  }
}
