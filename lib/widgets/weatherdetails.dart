import 'dart:developer';
import 'package:alarm_clock/utils/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:alarm_clock/utils/alltext.dart';
import 'package:alarm_clock/utils/colors.dart';

Widget weatherdetails({
  required String image,
  required String constTxt,
  required String? txt,
}) {
  Widget txtWidget;
  // Check if txt is a String
  if (txt is String) {
    // If txt is a String, display a Row with Text widgets
    txtWidget = alltext(
      txt: txt,
      col: bl,
      siz: 13.sp,
      wei: FontWeight.bold,
      max: 1,
    );
    log("String");
  } else {
    // If txt is not a String, display a CircularProgressIndicator

    txtWidget = const Row(
      children: [
        SizedBox(
          width: 20,
        ),
        SizedBox(
            child: SizedBox(
                height: 20, width: 20, child: CircularProgressIndicator())),
      ],
    );
    log("loading");
  }

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
            spreadRadius: 0.1,
          ),
        ],
      ),
      child: Center(
        child: ListTile(
          leading: Container(
            height: 8.h,
            width: 8.h,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(image),
              ),
            ),
          ),
          title: Row(
            children: [
              alltext(
                txt: constTxt,
                col: bl,
                siz: 13.sp,
                wei: FontWeight.bold,
                max: 1,
              ),
              txtWidget
            ],
          ),
        ),
      ),
    ),
  );
}
