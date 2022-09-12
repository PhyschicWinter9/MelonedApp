import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:newmelonedv2/model/weather.dart';

//Create Class WeatherApiClient form get location
class WeatherApiClient {
  // static const baseUrl = 'https://api.openweathermap.org/data/2.5';
  // static const baseUrlv3 = 'https://api.openweathermap.org/data/3.0';
  // static const apikey = '2d0ed5e7b2b8fed7f13f1890cdc4b8ab';
  // static const units = 'metric';
  // static const lang = 'th';

  // static const baseUrl1 = 'https://api.openweathermap.org/data/2.5/weather?lat=9.131790&lon=99.333618&units=metric&lang=th&appid=2d0ed5e7b2b8fed7f13f1890cdc4b8ab';

  Future<Weather>? getCurretWeather(String? lat, String? lon) async {
    final locationUrl =
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&units=metric&lang=th&appid=2d0ed5e7b2b8fed7f13f1890cdc4b8ab';

    var response = await http.get(Uri.parse(locationUrl));
    var body = jsonDecode(response.body);

    //Debug Log response
    // print(Weather.fromJson(body));
    // print(Weather.fromJson(body).lat);
    // print(Weather.fromJson(body).lon);
    // // print(Weather.fromJson(body).temp);
    // print(Weather.fromJson(body).cityname);
    return Weather.fromJson(body);
  }
}
