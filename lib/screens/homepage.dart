// ignore_for_file: avoid_print

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:noteapp/constants/appColors.dart';
import 'package:noteapp/constants/styleConst.dart';
import 'package:noteapp/models/categoryModel.dart';
import 'package:noteapp/models/noteDataModel.dart';
import 'package:noteapp/routes/routeNames.dart';
import 'package:noteapp/screens/editNotePage.dart';
import 'package:noteapp/services/darkModeServices.dart';
import 'package:noteapp/services/filterServices.dart';
import 'package:noteapp/services/noteDataManagement.dart';
import 'package:noteapp/utils/colorsLogic.dart';
import 'package:noteapp/utils/dateLogics.dart';
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
    final getNotes = ref.watch(filteredNotesProvider);
    final year = DateFormat('yyyy').format(today);
    final month = DateFormat('MMMM').format(today);
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: darkMode ? black : white,
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              final initialNote = NoteDataModel(
                id: 0,
                colors: black,
                title: '',
                content: '',
                category: CategoryModel(id: 0, title: ""),
                creationDate: null,
                modifiedDate: null,
              );
              context.pushNamed(RouteName.EDITPAGE, extra: initialNote);
            },
            backgroundColor: darkMode ? white.withOpacity(0.7) : black,
            child:  Center(
              child: Icon(Icons.add,color: darkMode?black:white,),
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
                  style: genStyle(ref).copyWith(color: black),
                  onChanged: (value) {
                    ref.read(filterSettingsProvider.notifier).updateSearchQuery(value);
                  },
                  decoration: InputDecoration(
                    hintText: "Search for notes",
                    hintStyle: genStyle(ref).copyWith(
                      color: darkMode ? black : black.withOpacity(0.4),
                    ),
                    filled: true,
                    fillColor: darkMode ? white.withOpacity(0.7) : black.withOpacity(0.05),
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
                  ref.read(filterSettingsProvider.notifier).updateStartDate(date);
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
                        FocusScope.of(context).unfocus();
                        ref.read(selectedIndex.notifier).state = index;

                        ref.read(filterSettingsProvider.notifier).updateSelectedCategory(
                              categories[index].title,
                            );
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
              getNotes.when(data: (data) {
                return data.isEmpty
                    ? Expanded(
                        child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "You have no Note\nAdd a new note ➕",
                            style: genStyle(ref),
                          )
                        ],
                      ))
                    : Expanded(
                        child: GridView.builder(
                            padding: const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
                            itemCount: data.length,
                            physics: const BouncingScrollPhysics(),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 15,
                              crossAxisSpacing: 15,
                              mainAxisExtent: 180,
                            ),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              final item = data[index];
                              return GestureDetector(
                                onTap: () {
                                  ref.read(genNoteData.notifier).state = item;
                                  context.pushNamed(RouteName.VIEWPAGE, extra: item);
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    color: item.colors,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        formatMyDate(
                                          item.creationDate ?? DateTime.now(),
                                        ),
                                        style: genStyle(ref).copyWith(
                                          fontSize: 10,
                                          color: black,
                                          fontStyle: FontStyle.italic,
                                        ),
                                      ),
                                      sizedBoxHeight(5),
                                      Text(
                                        item.title ?? "",
                                        style: genStyle(ref).copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: black,
                                        ),
                                      ),
                                      sizedBoxHeight(5),
                                      Expanded(
                                        child: Text(
                                          item.content ?? "",
                                          style: genStyle(ref).copyWith(fontSize: 12, color: black),
                                          overflow: TextOverflow.fade,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }),
                      );
              }, error: (err, stacktrace) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: SizedBox(
                        height: 30,
                        width: 30,
                        child: CircularProgressIndicator(
                          color: getRandomColor(),
                        ),
                      ),
                    ),
                  ],
                );
              }, loading: () {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: SizedBox(
                        height: 30,
                        width: 30,
                        child: CircularProgressIndicator(
                          color: getRandomColor(),
                        ),
                      ),
                    ),
                  ],
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
