// ignore_for_file: file_names

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noteapp/constants/appColors.dart';
import 'package:noteapp/screens/homepage.dart';
import 'package:noteapp/services/darkModeServices.dart';

Color getRandomColor() {
  List<Color> colorList = [
    const Color(0xffC2DCFD),
    const Color(0xffFFD8F9),
    const Color(0xffFBF6AA),
    const Color(0xffB0E96A),
    // const Color(0xffFCFADA),
    const Color(0xffF1DBF5),
    const Color(0xffD9E8FC),
    const Color(0xffFFDBE3),
  ];
  final Random random = Random();
  final int randomNumber = random.nextInt(colorList.length);
  return colorList[randomNumber];
}

Color getBorderColor(bool isSelected, bool darkMode) {
  switch (isSelected) {
    case true:
      return darkMode ? white : Colors.transparent;
    case false:
      return darkMode ? Colors.transparent : Colors.transparent;
    default:
      return Colors.transparent;
  }
}
Color getBorder(bool isSelected, bool darkMode) {
  switch (isSelected) {
    case true:
      return darkMode ? white : black.withOpacity(0.3);
    case false:
      return darkMode ? Colors.transparent : black.withOpacity(0.3);
    default:
      return black.withOpacity(0.2);
  }
}

Color getDateTimeLineColor(bool isSelected, bool darkMode) {
  if (isSelected && !darkMode) {
    return white;
  } else if (!isSelected && !darkMode) {
    return black;
  } else if (isSelected && darkMode) {
    return white;
  } else if (!isSelected && darkMode) {
    return white;
  } else {
    return Colors.transparent;
  }
}
