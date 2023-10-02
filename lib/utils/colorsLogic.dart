// ignore_for_file: file_names

import 'dart:math';

import 'package:flutter/material.dart';

Color getRandomColor() {
  List<Color> colorList = [
    const Color(0xffC2DCFD),
    const Color(0xffFFD8F9),
    const Color(0xffFBF6AA),
    const Color(0xffB0E96A),
    const Color(0xffFCFADA),
    const Color(0xffF1DBF5),
    const Color(0xffD9E8FC),
    const Color(0xffFFDBE3),
  ];
  final Random random = Random();
  final int randomNumber = random.nextInt(colorList.length);
  return colorList[randomNumber];
}
