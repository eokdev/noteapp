import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:noteapp/constants/appColors.dart';
import 'package:noteapp/constants/styleConst.dart';
import 'package:noteapp/models/noteDataModel.dart';
import 'package:noteapp/services/darkModeServices.dart';
import 'package:noteapp/widgets/spacing.dart';

class EditNotePage extends ConsumerStatefulWidget {
  final NoteDataModel? noteData;
  const EditNotePage({super.key, required this.noteData});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EditNotePageState();
}

class _EditNotePageState extends ConsumerState<EditNotePage> {
  quill.QuillController _controller = quill.QuillController.basic();
  var myJSON = jsonDecode(r'[{"insert":"hyugyfkvyfjty jhvuky\n"}]');
  @override
  void initState() {
    _controller = quill.QuillController(
      document: quill.Document.fromJson(myJSON),
      selection: const TextSelection.collapsed(offset: 0),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final darkMode = ref.watch(darkModeProvider);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: black,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                var json = jsonEncode(_controller.document.toDelta().toJson());
                print(json);
                showCategoryModal(context, ref);
              },
              tooltip: "Save Note",
              icon: const Icon(
                Icons.create_new_folder_outlined,
                color: black,
              ),
            ),
            IconButton(
              onPressed: () {
                context.pop();
              },
              tooltip: "Discard Changes",
              icon: const Icon(
                Icons.cancel_outlined,
                color: black,
              ),
            ),
            IconButton(
              onPressed: () {},
              tooltip: "Delete Note",
              icon: const Icon(
                Icons.delete_outline,
                color: black,
              ),
            ),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sizedBoxHeight(10),
            Padding(
              padding: const EdgeInsets.only(
                left: 15,
                right: 15,
              ),
              child: TextFormField(
                cursorColor: black.withOpacity(0.3),
                style: genStyle(ref).copyWith(
                  color: black,
                ),
                decoration: InputDecoration(
                  hintText: "Enter note title",
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
            Expanded(
              child: Container(
                child: quill.QuillEditor.basic(
                  controller: _controller,
                  readOnly: false,
                  padding: const EdgeInsets.only(left: 15, right: 15),
                ),
              ),
            ),
            Container(
              constraints: const BoxConstraints(
                minHeight: 60,
              ),
              width: double.infinity,
              margin: const EdgeInsets.only(
                bottom: 10,
                left: 15,
                right: 15,
              ),
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: black,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  quill.QuillToolbar.basic(
                    controller: _controller,
                    iconTheme: quill.QuillIconTheme(
                      borderRadius: 15,
                      iconSelectedFillColor: white.withOpacity(0.2),
                      iconUnselectedFillColor: white,
                    ),
                    color: black,
                    showListBullets: false,
                    showListCheck: false,
                    showListNumbers: false,
                    showFontSize: false,
                    showSearchButton: false,
                    showRightAlignment: true,
                    showCodeBlock: false,
                    showBackgroundColorButton: false,
                    showStrikeThrough: false,
                    showLink: false,
                    showSmallButton: false,
                    showDirection: false,
                    showDividers: false,
                    showInlineCode: false,
                    showColorButton: false,
                    showJustifyAlignment: false,
                    showLeftAlignment: true,
                    showCenterAlignment: true,
                    showSubscript: false,
                    showSuperscript: false,
                    showFontFamily: false,
                    showQuote: false,
                    showHeaderStyle: false,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  showCategoryModal(BuildContext context, WidgetRef ref) {
    return showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: ((context) {
        return Consumer(builder: (context, ref, child) {
          final check = ref.watch(checker);
          return Container(
            height: MediaQuery.of(context).size.height * 0.6,
            decoration: const BoxDecoration(
              color: white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
            ),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Aligns children at start and end of the row
                        children: [
                          const Spacer(),
                          Align(
                            alignment: Alignment.topCenter,
                            child: Text(
                              "Category",
                              style: genStyle(ref).copyWith(fontWeight: FontWeight.bold),
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: () {
                              context.pop();
                            },
                            icon: Icon(
                              Icons.cancel,
                              color: black.withOpacity(0.3),
                            ),
                          )
                        ],
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        visualDensity: const VisualDensity(vertical: 0, horizontal: 0),
                        leading: Icon(
                          Icons.add_circle_outline_rounded,
                          color: black.withOpacity(0.5),
                        ),
                        minLeadingWidth: 0,
                        title: Text(
                          "Add a new category",
                          style: genStyle(ref).copyWith(color: black.withOpacity(0.5)),
                        ),
                        trailing: Icon(
                          Icons.check_circle_outline_outlined,
                          color: black.withOpacity(0.5),
                        ),
                      ),
                      Divider(
                        color: black.withOpacity(0.1),
                        thickness: 0,
                      ),
                      Expanded(
                          child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: 10,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    ListTile(
                                      contentPadding: EdgeInsets.zero,
                                      visualDensity: const VisualDensity(vertical: -4, horizontal: 0),
                                      minLeadingWidth: 0,
                                      title: Text(
                                        "Cart",
                                        style: genStyle(ref),
                                      ),
                                      trailing: GestureDetector(
                                        onTap: () {
                                          ref.read(checker.notifier).state = index;
                                        },
                                        child: Builder(builder: (context) {
                                          return CircleAvatar(
                                            radius: 12,
                                            backgroundColor: black.withOpacity(0.2),
                                            child: CircleAvatar(
                                              radius: 10,
                                              backgroundColor: check == index ? black : white,
                                              child: Center(
                                                child: check == index
                                                    ? const Icon(
                                                        Icons.check,
                                                        color: white,
                                                        size: 13,
                                                      )
                                                    : const CircleAvatar(
                                                        backgroundColor: white,
                                                      ),
                                              ),
                                            ),
                                          );
                                        }),
                                      ),
                                    ),
                                    Divider(
                                      color: black.withOpacity(0.1),
                                      thickness: 0,
                                    ),
                                  ],
                                );
                              }))
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 100,
                    color: white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 40,
                          margin: const EdgeInsets.only(left: 20, right: 20),
                          decoration: BoxDecoration(
                            color: black,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          width: double.infinity,
                          child: Center(
                            child: Text(
                              "Save",
                              style: genStyle(ref).copyWith(
                                color: white,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        });
      }),
    );
  }
}

final checker = StateProvider<int>((ref) => -1);
