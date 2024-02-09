import 'dart:convert';
import 'dart:developer';
import 'package:alarm_clock/providers/getweather_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:alarm_clock/models/weathermodel.dart';
import 'package:alarm_clock/utils/apiconfig.dart';
import 'package:alarm_clock/utils/constant.dart';

class CityWeatherDetailsServices extends ChangeNotifier {
  final Apiconfigration api = Apiconfigration();
  WeatherDetailsServices weatherController;
  bool isLoading = false;
  WeatherModel? reply;
  CityWeatherDetailsServices(this.weatherController);

  void updateWeatherDetails(WeatherDetailsServices weatherDetailsServices) {
    weatherController = weatherDetailsServices;
    notifyListeners();
  }

  Future<void> getWeather({required String cityname}) async {
    try {
      isLoading = true;
      notifyListeners();

      final response =
          await http.get(Uri.parse("${baseurl}q=$cityname&appid=$apiKey"));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        reply = WeatherModel.fromJson(data);
        log("${reply?.message.toString()}------------");
        weatherController.getWeather(
            lat: reply!.city.coord.lat, long: reply!.city.coord.lon);

        isLoading = false;
        notifyListeners();
      } else {
        isLoading = false;
        log('failed');
        notifyListeners();
      }
    } catch (e) {
      log(e.toString());
      isLoading = false;
      notifyListeners();
    }
  }
}
