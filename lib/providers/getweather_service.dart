import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:alarm_clock/models/weathermodel.dart';
import 'package:alarm_clock/utils/apiconfig.dart';
import 'package:alarm_clock/utils/constant.dart';

class WeatherDetailsServices extends ChangeNotifier {
  final Apiconfigration api = Apiconfigration();
  bool isLoading = false;
  WeatherModel? reply;

  Future<void> getWeather({required double lat, required double long}) async {
    try {
      isLoading = true;
      notifyListeners();

      final response = await http
          .get(Uri.parse("${baseurl}lat=$lat&lon=$long&appid=$apiKey"));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        reply = WeatherModel.fromJson(data);
        log("${reply?.message.toString()}------------");

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

  Future<void> getLocationAndFetchWeather() async {
    try {
      LocationPermission locationPermission =
          await Geolocator.checkPermission();
      if (locationPermission == LocationPermission.denied ||
          locationPermission == LocationPermission.deniedForever) {
        log('permission not given');
        notifyListeners();
      } else {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best);
        log("${position.latitude.toString()}--------------latitude-------------->");
        log("${position.longitude.toString()}---------------longitude-------");

        await getWeather(
            lat: position.latitude.toDouble(),
            long: position.longitude.toDouble());
        notifyListeners();
      }
    } catch (e) {
      log(e.toString());
      isLoading = false;
      notifyListeners();
    }
  }

  void onInit() async {
    log('onInit called');
    await getLocationAndFetchWeather();
  }
}
