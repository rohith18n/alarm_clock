import 'dart:developer';
import 'package:alarm_clock/providers/getcityweather_service.dart';
import 'package:alarm_clock/utils/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:provider/provider.dart';
import 'package:alarm_clock/utils/alltext.dart';
import 'package:alarm_clock/utils/colors.dart';

Widget citysList(BuildContext context) {
  final CityWeatherDetailsServices cityweatherController =
      Provider.of<CityWeatherDetailsServices>(
          context); // Access CityWeatherDetailsServices using Provider.of

  List<String> citynames = [
    "Mumbai",
    "Delhi",
    "Kolkata",
    "Chennai",
    "Bengaluru",
    "Hyderabad",
    "Pune",
    "Ahmedabad",
    "Jaipur",
    "Surat",
    "Lucknow",
    "Kanpur",
    "Nagpur",
    "Chandigarh",
    "Visakhapatnam"
  ];

  return SizedBox(
    height: 10.h,
    width: 77.w,
    child: ListView.separated(
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(top: 2.h, left: 1.h, bottom: 2.h),
          child: InkWell(
            onTap: () {
              cityweatherController.getWeather(cityname: citynames[index]);
              log(citynames[index]);
            },
            child: Container(
              height: 3.h,
              width: 27.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(1.5.h),
                color: CustomColors.secHandColor,
              ),
              child: Center(
                child: alltext(
                  txt: citynames[index].toString(),
                  col: wh,
                  siz: 12.sp,
                  wei: FontWeight.bold,
                  max: 1,
                ),
              ),
            ),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return SizedBox(
          width: 3.w,
        );
      },
      itemCount: citynames.length,
    ),
  );
}
