// ignore_for_file: avoid_print

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:noteapp/constants/appColors.dart';
import 'package:noteapp/constants/styleConst.dart';
import 'package:noteapp/models/noteDataModel.dart';
import 'package:noteapp/services/darkModeServices.dart';
import 'package:noteapp/utils/colorsLogic.dart';
import 'package:noteapp/utils/lists.dart';
import 'package:noteapp/widgets/datePicker.dart';
import 'package:noteapp/widgets/spacing.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';

final selectedIndex = StateProvider<int>((ref) => 0);

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final today = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final darkMode = ref.watch(darkModeProvider);
    List<NoteDataModel> model = [
      NoteDataModel(
        colors: getRandomColor(),
        creationDate: DateTime.now(),
        modifiedDate: DateTime.now(),
        title: "Procreation",
        content:
            "I am trying to do something really special today so if you are seeing this message just know that they are things that are about to be broadcasted to be one or more to the eligiblilty of yuour service in our instititue i am very muxch pleased to be doing this with you guys, just han",
      ),
      NoteDataModel(
        colors: getRandomColor(),
        creationDate: DateTime.now(),
        modifiedDate: DateTime.now(),
        title: "Events",
        content:
            "I am trying to do something really special today so if you are seeing this message just know that they are things that are about to be broadcasted to be one or more to the eligiblilty of yuour service in our instititue i am very muxch pleased to be doing this with you guys, just han",
      ),
      NoteDataModel(
        colors: getRandomColor(),
        creationDate: DateTime.now(),
        modifiedDate: DateTime.now(),
        title: "Kitchen",
        content:
            "I am trying to do something really special today so if you are seeing this message just know that they are things that are about to be broadcasted to be one or more to the eligiblilty of yuour service in our instititue i am very muxch pleased to be doing this with you guys, just han",
      ),
      NoteDataModel(
        colors: getRandomColor(),
        creationDate: DateTime.now(),
        modifiedDate: DateTime.now(),
        title: "Game",
        content:
            "I am trying to do something really special today so if you are seeing this message just know that they are things that are about to be broadcasted to be one or more to the eligiblilty of yuour service in our instititue i am very muxch pleased to be doing this with you guys, just han",
      ),
      NoteDataModel(
        colors: getRandomColor(),
        creationDate: DateTime.now(),
        modifiedDate: DateTime.now(),
        title: "Fun",
        content:
            "I am trying to do something really special today so if you are seeing this message just know that they are things that are about to be broadcasted to be one or more to the eligiblilty of yuour service in our instititue i am very muxch pleased to be doing this with you guys, just han",
      ),
      NoteDataModel(
        colors: getRandomColor(),
        creationDate: DateTime.now(),
        modifiedDate: DateTime.now(),
        title: "Creation",
        content:
            "I am trying to do something really special today so if you are seeing this message just know that they are things that are about to be broadcasted to be one or more to the eligiblilty of yuour service in our instititue i am very muxch pleased to be doing this with you guys, just han",
      ),
    ];
    final year = DateFormat('yyyy').format(today);
    final month = DateFormat('MMMM').format(today);
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          backgroundColor: darkMode ? black : white,
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            backgroundColor: black,
            child: const Center(
              child: Icon(Icons.add),
            ),
          ),
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
                            style: TextStyle(
                              fontFamily: "Avenir",
                              color: darkMode ? white : black,
                              fontSize: 17,
                            ),
                          ),
                          TextSpan(
                            text: " $month",
                            style: TextStyle(
                              fontFamily: "Avenir",
                              color: darkMode ? white : black,
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
                        icon: Icon(
                          Icons.more_vert,
                          color: darkMode ? white : black,
                        ),
                        padding: EdgeInsets.zero,
                        color: darkMode ? black : white,
                        constraints: const BoxConstraints(),
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                            color: white,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        itemBuilder: (context) {
                          return [
                            PopupMenuItem(
                              padding: const EdgeInsets.only(left: 10),
                              value: "Switch Mode",
                              child: GestureDetector(
                                onTap: () {
                                  ref.read(darkModeProvider.notifier).toggle();
                                  context.pop();
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      "Switch to \n${darkMode ? "Light" : "Dark"} Mode",
                                      textAlign: TextAlign.center,
                                      style: genStyle(ref).copyWith(fontSize: 12),
                                    ),
                                    Icon(
                                      Icons.nights_stay,
                                      color: darkMode ? white : black,
                                    ),
                                  ],
                                ),
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
                  style: genStyle(ref),
                  decoration: InputDecoration(
                    hintText: "Search for notes",
                    hintStyle: genStyle(ref).copyWith(
                      color: darkMode ? black : black.withOpacity(0.4),
                    ),
                    filled: true,
                    fillColor: darkMode ? white : black.withOpacity(0.05),
                    prefixIcon: Icon(
                      Icons.search,
                      color: darkMode ? black : black.withOpacity(0.3),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              sizedBoxHeight(10),
              DatePickers(
                DateTime.now(),
                initialSelectedDate: DateTime.now(),
                onDateChange: (date) {
                  setState(() {
                    print(date);
                  });
                },
              ),
              sizedBoxHeight(10),
              SizedBox(
                height: 30,
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  physics: const BouncingScrollPhysics(),
                  children: List.generate(categories.length, (index) {
                    return GestureDetector(
                      onTap: () {
                        ref.read(selectedIndex.notifier).state = index;
                      },
                      child: Container(
                        margin: const EdgeInsets.only(left: 8, right: 8),
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: ref.watch(selectedIndex) == index ? black : Colors.transparent,
                          border: Border.all(
                            color: getBorder(ref.watch(selectedIndex) == index, darkMode),
                            width: 0.5,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            categories[index].title ?? "",
                            style: genStyle(ref).copyWith(
                              color: getDateTimeLineColor(
                                ref.watch(selectedIndex) == index,
                                darkMode,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
              sizedBoxHeight(10),
              Expanded(
                child: GridView.builder(
                    padding: const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
                    itemCount: model.length,
                    physics: const BouncingScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 15,
                      crossAxisSpacing: 15,
                      mainAxisExtent: 180,
                    ),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final item = model[index];
                      return Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: item.colors,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.title ?? "",
                              style: genStyle(ref).copyWith(fontWeight: FontWeight.bold),
                            ),
                            sizedBoxHeight(5),
                            Expanded(
                              child: Text(
                                item.content ?? "",
                                style: genStyle(ref).copyWith(fontSize: 12),
                                overflow: TextOverflow.fade,
                              ),
                            )
                          ],
                        ),
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
