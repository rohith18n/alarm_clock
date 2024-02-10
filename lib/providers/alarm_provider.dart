import 'dart:async';
import 'dart:developer';
import 'package:alarm_clock/main.dart';
import 'package:flutter/material.dart';
import 'package:alarm_clock/services/alarm_helper.dart';
import 'package:alarm_clock/models/alarm_info.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class AlarmController extends ChangeNotifier {
  DateTime? alarmTime;
  late String alarmTimeString;
  bool isRepeatSelected = false;
  final AlarmHelper _alarmHelper = AlarmHelper();
  Future<List<AlarmInfo>>? alarms;
  List<AlarmInfo>? currentAlarms;

  void initAlarm() {
    alarmTime = DateTime.now();
    _alarmHelper.initializeDatabase().then((value) {
      log('------database intialized');
      loadAlarms();
    });
  }

  void loadAlarms() {
    alarms = _alarmHelper.getAlarms();
    notifyListeners();
  }

  void deleteAlarm(int? id) {
    _alarmHelper.delete(id);
    //unsubscribe for notification
    loadAlarms();
  }

  void updateIsRepeatSelected(bool value) {
    isRepeatSelected = value;
    notifyListeners();
  }

  void scheduleAlarm(
      DateTime scheduledNotificationDateTime, AlarmInfo alarmInfo,
      {required bool isRepeating}) async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'alarm_notif',
      'alarm_notif',
      channelDescription: 'Channel for Alarm notification',
      icon: 'appstore',
      sound: RawResourceAndroidNotificationSound('a_long_cold_sting'),
      largeIcon: DrawableResourceAndroidBitmap('appstore'),
    );

    var iOSPlatformChannelSpecifics = const IOSNotificationDetails(
      sound: 'a_long_cold_sting.wav',
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    if (isRepeating) {
      // ignore: deprecated_member_use
      await flutterLocalNotificationsPlugin.showDailyAtTime(
        0,
        'Office',
        alarmInfo.title,
        Time(
          scheduledNotificationDateTime.hour,
          scheduledNotificationDateTime.minute,
          scheduledNotificationDateTime.second,
        ),
        platformChannelSpecifics,
      );
    } else {
      await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        'Office',
        alarmInfo.title,
        tz.TZDateTime.from(scheduledNotificationDateTime, tz.local),
        platformChannelSpecifics,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );
    }
  }

  void onSaveAlarm(bool _isRepeating, BuildContext context) {
    DateTime? scheduleAlarmDateTime;
    if (alarmTime!.isAfter(DateTime.now())) {
      scheduleAlarmDateTime = alarmTime;
    } else {
      scheduleAlarmDateTime = alarmTime!.add(const Duration(days: 1));
    }

    var alarmInfo = AlarmInfo(
      alarmDateTime: scheduleAlarmDateTime,
      gradientColorIndex: currentAlarms!.length,
      title: 'alarm',
    );
    _alarmHelper.insertAlarm(alarmInfo);
    if (scheduleAlarmDateTime != null) {
      scheduleAlarm(scheduleAlarmDateTime, alarmInfo,
          isRepeating: _isRepeating);
    }
    Navigator.pop(context);
    loadAlarms();
  }
}
