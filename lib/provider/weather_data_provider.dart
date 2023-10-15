import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/models/weather_report_model.dart';

class WeatherDataProvider with ChangeNotifier {
  dynamic _position = {"lat": "", "long": ""};
  dynamic get position => _position;

  String _resData = "";
  String get resData => _resData;

  Temperatures _report = Temperatures.empty();
  Temperatures get report => _report;

  Future<void> getLatLong(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;
    Position position;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      const snackBar = SnackBar(
        content: Text('Location Permission Granted! Please Refresh once.'),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    position = await Geolocator.getCurrentPosition();

    _position = {
      "lat": position.latitude.toString(),
      "long": position.longitude.toString()
    };

    notifyListeners();
  }

  Future<void> fetchWeatherReports(position) async {
    var latitude = position["lat"];
    var longitude = position["long"];
    var dio = Dio();
    var response = await dio.request(
      'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=8dde22f249629fa2b295d6ce68ded4f9',
      options: Options(
        method: 'GET',
      ),
    );

    if (response.statusCode == 200) {
      print(json.encode(response.data));
      Map<String, dynamic> jsonMap = response.data;
      var temperatures = Temperatures(
        coord:
            Coord(lon: jsonMap['coord']['lon'], lat: jsonMap['coord']['lat']),
        weather: (jsonMap['weather'] as List)
            .map((weatherJson) => Weather(
                  id: weatherJson['id'],
                  main: weatherJson['main'],
                  description: weatherJson['description'],
                  icon: weatherJson['icon'],
                ))
            .toList(),
        base: jsonMap['base'],
        main: Main(
          temp: jsonMap['main']['temp'],
          feelsLike: jsonMap['main']['feels_like'],
          tempMin: jsonMap['main']['temp_min'],
          tempMax: jsonMap['main']['temp_max'],
          pressure: jsonMap['main']['pressure'],
          humidity: jsonMap['main']['humidity'],
        ),
        visibility: jsonMap['visibility'],
        wind:
            Wind(speed: jsonMap['wind']['speed'], deg: jsonMap['wind']['deg']),
        clouds: Clouds(all: jsonMap['clouds']['all']),
        dt: jsonMap['dt'],
        sys: Sys(
          type: jsonMap['sys']['type'],
          id: jsonMap['sys']['id'],
          country: jsonMap['sys']['country'],
          sunrise: jsonMap['sys']['sunrise'],
          sunset: jsonMap['sys']['sunset'],
        ),
        timezone: jsonMap['timezone'],
        id: jsonMap['id'],
        name: jsonMap['name'],
        cod: jsonMap['cod'],
      );

      _report = temperatures;
    } else {
      print(response.statusMessage);
    }
  }
}
