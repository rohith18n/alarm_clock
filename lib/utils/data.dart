import 'package:alarm_clock/models/alarm_info.dart';
import 'package:alarm_clock/providers/menu_info.dart';
import 'package:alarm_clock/utils/enums.dart';

List<MenuInfo> menuItems = [
  MenuInfo(MenuType.clock,
      title: 'Clock', imageSource: 'assets/clock_icon.png'),
  MenuInfo(MenuType.alarm,
      title: 'Alarm', imageSource: 'assets/alarm_icon.png'),
  MenuInfo(MenuType.weather,
      title: 'Weather', imageSource: 'assets/timer_icon.png'),
];

List<AlarmInfo> alarms = [
  AlarmInfo(
      alarmDateTime: DateTime.now().add(const Duration(hours: 1)),
      title: 'Office',
      gradientColorIndex: 0),
  AlarmInfo(
      alarmDateTime: DateTime.now().add(const Duration(hours: 2)),
      title: 'Sport',
      gradientColorIndex: 1),
];
