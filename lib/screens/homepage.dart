import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:noteapp/constants/appColors.dart';
import 'package:noteapp/constants/styleConst.dart';
import 'package:noteapp/widgets/spacing.dart';
import 'dart:developer' as dev;

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final today = DateTime.now();
  @override
  Widget build(BuildContext context) {
    final year = DateFormat('yyyy').format(today);
    final month = DateFormat('MMMM').format(today);
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          backgroundColor: white,
          body: Column(
            children: [
              sizedBoxHeight(10),
              Padding(
                padding: const EdgeInsets.only(
                  left: 15,
                  right: 15,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: year,
                            style: const TextStyle(
                              fontFamily: "Avenir",
                              color: black,
                              fontSize: 17,
                            ),
                          ),
                          TextSpan(
                            text: " $month",
                            style: const TextStyle(
                              fontFamily: "Avenir",
                              color: black,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    PopupMenuButton(
                        onSelected: (value) {
                          print("jkdskjdsj");
                        },
                        elevation: 1,
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        itemBuilder: (context) {
                          return [
                            const PopupMenuItem(
                              value: "Switch Mood",
                              child: Row(
                                children: [Text("Switch Mood"), Icon(Icons.nights_stay)],
                              ),
                            ),
                          ];
                        })
                  ],
                ),
              ),
              sizedBoxHeight(10),
              Padding(
                padding: const EdgeInsets.only(
                  left: 15,
                  right: 15,
                ),
                child: TextFormField(
                  cursorColor: black.withOpacity(0.3),
                  style: genStyle.copyWith(
                    color: black,
                  ),
                  decoration: InputDecoration(
                    hintText: "Search for notes",
                    hintStyle: genStyle.copyWith(
                      color: black.withOpacity(0.4),
                    ),
                    filled: true,
                    fillColor: black.withOpacity(0.1),
                    prefixIcon: Icon(
                      Icons.search,
                      color: black.withOpacity(0.3),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              sizedBoxHeight(10),
            ],
          ),
        ),
      ),
    );
  }
}
