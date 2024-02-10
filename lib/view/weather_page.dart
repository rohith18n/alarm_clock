import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import Provider package
import 'package:sizer/sizer.dart';
import 'package:alarm_clock/utils/alltext.dart';
import 'package:alarm_clock/utils/colors.dart';
import 'package:alarm_clock/widgets/city_list.dart';
import 'package:alarm_clock/widgets/weatherdetails.dart';
import 'package:alarm_clock/providers/getweather_service.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<WeatherDetailsServices>(
        // Use Consumer to listen for changes in WeatherDetailsServices
        builder: (context, weatherController, child) {
          if (weatherController.reply == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (weatherController.reply?.list.isEmpty ?? true) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    alltext(
                      txt: "Reload",
                      col: bl,
                      siz: 18.sp,
                      wei: FontWeight.bold,
                      max: 1,
                    ),
                    IconButton(
                      onPressed: () {
                        weatherController.getLocationAndFetchWeather();
                      },
                      icon: Icon(
                        Icons.restart_alt,
                        color: wh,
                        size: 4.h,
                      ),
                    )
                  ],
                ),
                Center(
                  child: alltext(
                    txt: "Weather data is empty",
                    col: bl,
                    siz: 15.sp,
                    wei: FontWeight.bold,
                    max: 1,
                  ),
                ),
              ],
            );
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    child: alltext(
                      txt: "Weather",
                      col: bl,
                      siz: 15.sp,
                      wei: FontWeight.bold,
                      max: 1,
                    ),
                  ),
                ),
                citysList(context),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    child: Center(
                      child: TextButton.icon(
                        onPressed: () {},
                        icon: Icon(
                          Icons.location_on_outlined,
                          color: re,
                        ),
                        label: weatherController.isLoading
                            ? const SizedBox(
                                child: SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator()))
                            : alltext(
                                txt: weatherController.reply?.city.name ?? 'm/',
                                col: bl,
                                siz: 15.sp,
                                wei: FontWeight.bold,
                                max: 1,
                              ),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    alltext(
                      txt: "Reset",
                      col: bl,
                      siz: 16.sp,
                      wei: FontWeight.bold,
                      max: 1,
                    ),
                    IconButton(
                      onPressed: () {
                        weatherController.getLocationAndFetchWeather();
                      },
                      icon: Icon(
                        Icons.restart_alt,
                        color: wh,
                        size: 3.h,
                      ),
                    )
                  ],
                ),
                weatherdetails(
                  txt: weatherController.isLoading != true
                      ? " ${weatherController.reply!.list[0].main.temp.toString()}"
                      : null,
                  image: 'images/temperature.png',
                  constTxt: 'Temp :',
                ),
                weatherdetails(
                  image: 'images/pressure.png',
                  txt: weatherController.isLoading != true
                      ? ' ${weatherController.reply!.list[0].main.pressure.toString()}'
                      : null,
                  constTxt: 'Pressure :',
                ),
                weatherdetails(
                  image: 'images/humidity.png',
                  txt: weatherController.isLoading != true
                      ? ' ${weatherController.reply!.list[0].main.humidity.toString()}'
                      : null,
                  constTxt: 'Humidity :',
                ),
                weatherdetails(
                  txt: weatherController.isLoading != true
                      ? '  ${weatherController.reply!.list[0].clouds.all.toString()}'
                      : null,
                  image: 'images/cloud cover.png',
                  constTxt: 'Cloud Cover :',
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
