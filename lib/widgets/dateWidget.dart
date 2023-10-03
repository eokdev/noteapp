/// ***
/// This class consists of the DateWidget that is used in the ListView.builder
///
/// Author: Vivek Kaushik <me@vivekkasuhik.com>
/// github: https://github.com/iamvivekkaushik/
/// ***

import 'package:date_picker_timeline/gestures/tap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:noteapp/constants/appColors.dart';
import 'package:noteapp/screens/homepage.dart';
import 'package:noteapp/services/darkModeServices.dart';

class DateWidgets extends StatelessWidget {
  final double? width;
  final DateTime date;
  final int select;
  final TextStyle? monthTextStyle, dayTextStyle, dateTextStyle;
  final Color selectionColor;
  final DateSelectionCallback? onDateSelected;
  final String? locale;

  const DateWidgets({
    Key? key,
    this.width,
    required this.date,
    required this.select,
    required this.dateTextStyle,
    required this.selectionColor,
    this.onDateSelected,
    this.locale,
    this.monthTextStyle,
    this.dayTextStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final darkMode = ref.watch(darkModeProvider);
      return InkWell(
        child: Container(
          width: width,
          margin: const EdgeInsets.all(3.0),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(8.0)),
            border: Border.all(
              color: darkMode ? white : black,
            ),
            color: selectionColor,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(DateFormat("MMM", locale).format(date).toUpperCase(), // Month
                    style: monthTextStyle),
                Text(date.day.toString(), // Date
                    style: dateTextStyle),
                Text(DateFormat("E", locale).format(date).toUpperCase(), // WeekDay
                    style: dayTextStyle)
              ],
            ),
          ),
        ),
        onTap: () {
          // Check if onDateSelected is not null
          if (onDateSelected != null) {
            // Call the onDateSelected Function
            onDateSelected!(date);
          }
        },
      );
    });
  }
}
