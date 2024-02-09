import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ClockProvider extends ChangeNotifier {
  var formattedTime = DateFormat('HH:mm').format(DateTime.now());
  late Timer timer;

  ClockProvider() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      var previousMinute =
          DateTime.now().add(const Duration(seconds: -1)).minute;
      var currentMinute = DateTime.now().minute;
      if (previousMinute != currentMinute) {
        formattedTime = DateFormat('HH:mm').format(DateTime.now());
        notifyListeners(); // Notify listeners to update the UI
      }
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}
