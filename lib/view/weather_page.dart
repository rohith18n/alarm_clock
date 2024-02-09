import 'package:alarm_clock/providers/getweather_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import Provider package
import 'package:sizer/sizer.dart';
import 'package:alarm_clock/utils/alltext.dart';
import 'package:alarm_clock/utils/colors.dart';
import 'package:alarm_clock/widgets/city_list.dart';
import 'package:alarm_clock/widgets/weatherdetails.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Access the WeatherDetailsServices instance using Provider

    return SafeArea(
      child: Consumer<WeatherDetailsServices>(
        // Use Consumer to listen for changes in WeatherDetailsServices
        builder: (context, weatherController, child) {
          if (weatherController.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (weatherController.reply == null) {
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
                        max: 1),
                    IconButton(
                        onPressed: () {
                          weatherController.getLocationAndFetchWeather();
                        },
                        icon: Icon(
                          Icons.restart_alt,
                          color: wh,
                          size: 4.h,
                        ))
                  ],
                ),
                Center(
                  child: alltext(
                      txt: "Weather data is empty",
                      col: bl,
                      siz: 15.sp,
                      wei: FontWeight.bold,
                      max: 1),
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
                          max: 1)),
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
                            label: alltext(
                                txt: weatherController.reply?.city.name ?? 'm/',
                                col: bl,
                                siz: 15.sp,
                                wei: FontWeight.bold,
                                max: 1)),
                      ),
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    alltext(
                        txt: "Reset",
                        col: bl,
                        siz: 16.sp,
                        wei: FontWeight.bold,
                        max: 1),
                    IconButton(
                        onPressed: () {
                          weatherController.getLocationAndFetchWeather();
                        },
                        icon: Icon(
                          Icons.restart_alt,
                          color: wh,
                          size: 3.h,
                        ))
                  ],
                ),
                weatherdetails(
                    txt:
                        "Temperature : ${weatherController.reply?.list[0].main.temp.toString()}",
                    image:
                        'images/high-temperature-icon-cartoon-high-temperature-vector-icon-web-design-isolated-white-background_98402-42475.jpg'),
                weatherdetails(
                    image: 'images/download.png',
                    txt:
                        'Pressure : ${weatherController.reply?.list[0].main.pressure.toString()}'),
                weatherdetails(
                    image: 'images/4148460.png',
                    txt:
                        'Humidity : ${weatherController.reply?.list[0].main.humidity.toString()}'),
                weatherdetails(
                    txt:
                        'Cloud Cover : ${weatherController.reply?.list[0].clouds.all.toString()}',
                    image:
                        'images/png-transparent-cloud-computing-computer-icons-cloud-cover-draw-cloud-computer-wallpaper-cloud-computing-thumbnail.png')
              ],
            );
          }
        },
      ),
    );
  }
}
