import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noteapp/constants/appColors.dart';
import 'package:noteapp/services/darkModeServices.dart';

TextStyle genStyle(WidgetRef ref) {
  final darkMode = ref.watch(darkModeProvider);
  return TextStyle(
    fontFamily: "Avenir",
    color: darkMode ? white : black,
  );
}

