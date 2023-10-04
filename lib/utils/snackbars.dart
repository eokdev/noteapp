import 'package:flutter/material.dart';
import 'package:noteapp/constants/appColors.dart';
import 'package:noteapp/constants/styleConst.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> snackBar({
  required String? content,
  required BuildContext context,
  required Color? backgroundColor,
}) {
  final snackbar = SnackBar(
    backgroundColor: backgroundColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    behavior: SnackBarBehavior.floating,
    duration: const Duration(seconds: 1),
    content: Text(
      content!,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontFamily: "Avenir",
        color: white,
      ),
    ),
  );

  return ScaffoldMessenger.of(context).showSnackBar(snackbar);
}
