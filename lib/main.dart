import 'package:alarm_clock/models/menu_info.dart';
import 'package:alarm_clock/providers/getcityweather_service.dart';
import 'package:alarm_clock/providers/getweather_service.dart';
import 'package:alarm_clock/utils/enums.dart';
import 'package:alarm_clock/view/homepage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var initializationSettingsAndroid =
      const AndroidInitializationSettings('appstore');
  var initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification:
          (int id, String? title, String? body, String? payload) async {});
  var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String? payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
  });

  runApp(Sizer(builder: (context, orientation, deviceType) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MenuInfo>(
          create: (context) => MenuInfo(MenuType.clock),
        ),
        ChangeNotifierProvider<WeatherDetailsServices>(
          create: (context) => WeatherDetailsServices(),
        ),
        ChangeNotifierProxyProvider<WeatherDetailsServices,
            CityWeatherDetailsServices>(
          create: (context) => CityWeatherDetailsServices(
              Provider.of<WeatherDetailsServices>(context, listen: false)),
          update:
              (context, weatherDetailsServices, cityWeatherDetailsServices) =>
                  cityWeatherDetailsServices!
                    ..updateWeatherDetails(weatherDetailsServices),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const HomePage(),
      ),
    );
  }));
}
