import 'package:flutter/material.dart';

Widget alltext(
    {required var txt,
    required Color col,
    required double siz,
    required var wei,
    required var max}) {
  return Text(
    txt,
    style: TextStyle(
        fontSize: siz,
        fontWeight: wei,
        color: Colors.white,
        fontFamily: 'avenir'),
    maxLines: max,
  );
}
