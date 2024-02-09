import 'package:alarm_clock/utils/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:alarm_clock/utils/alltext.dart';
import 'package:alarm_clock/utils/colors.dart';

weatherdetails({required var image, required var txt}) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Container(
      height: 12.h,
      width: 100.w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: CustomColors.clockBG,
          boxShadow: [
            BoxShadow(
                color: bl.withOpacity(0.6),
                offset: const Offset(2, 2),
                blurRadius: 0.1,
                spreadRadius: 0.1)
          ]),
      child: Center(
        child: ListTile(
          leading: Container(
            height: 8.h,
            width: 8.h,
            decoration:
                BoxDecoration(image: DecorationImage(image: AssetImage(image))),
          ),
          title: alltext(
              txt: txt, col: bl, siz: 13.sp, wei: FontWeight.bold, max: 1),
        ),
      ),
    ),
  );
}
