import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:noteapp/constants/appColors.dart';
import 'package:noteapp/constants/styleConst.dart';
import 'package:noteapp/models/noteDataModel.dart';
import 'package:noteapp/routes/routeNames.dart';
import 'package:noteapp/screens/editNotePage.dart';
import 'package:noteapp/services/darkModeServices.dart';
import 'package:noteapp/services/noteDataManagement.dart';
import 'package:noteapp/services/pdfsharing.dart';
import 'package:noteapp/utils/colorsLogic.dart';
import 'package:noteapp/utils/dateLogics.dart';
import 'package:noteapp/utils/snackbars.dart';
import 'package:noteapp/widgets/spacing.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;

final shareLoading = StateProvider<bool>((ref) => false);

class NoteViewingPage extends ConsumerStatefulWidget {
  final NoteDataModel noteData;
  const NoteViewingPage({super.key, required this.noteData});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NoteViewingPageState();
}

class _NoteViewingPageState extends ConsumerState<NoteViewingPage> {
  quill.QuillController _controller = quill.QuillController.basic();

  @override
  void initState() {
    _controller = quill.QuillController(
      document: quill.Document.fromJson(widget.noteData.body!),
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
            icon: Icon(
              Icons.arrow_back_rounded,
              color: darkMode ? white : black,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                ref.read(genNoteData.notifier).state = widget.noteData;

                context.pushReplacementNamed(
                  RouteName.EDITPAGE,
                  extra: widget.noteData,
                );
              },
              tooltip: "Edit Note",
              icon: Icon(
                Icons.mode_edit_outlined,
                color: darkMode ? white : black,
              ),
            ),
            Consumer(builder: (context, ref, child) {
              final loading = ref.watch(shareLoading);
              ref.listen(shareProviderRes, (previous, next) {
                if (next == "Yes") {
                  ref.read(shareProviderRes.notifier).state = "";
                  ref.read(shareLoading.notifier).state = false;
                } else {
                  ref.read(shareProviderRes.notifier).state = "";
                  ref.read(shareLoading.notifier).state = false;
                }
              });
              return loading
                  ? Column(
                      children: [
                        SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: getRandomColor(),
                          ),
                        ),
                      ],
                    )
                  : IconButton(
                      onPressed: () {
                        // final json = _controller.document.toDelta().toJson();
                        ref.read(shareLoading.notifier).state = true;
                        String content = _controller.document.toPlainText();
                        final datas = ShareResModel(
                          context,
                          content,
                          widget.noteData.title,
                        );
                        ref.read(
                          share(datas),
                        );
                      },
                      tooltip: "Share",
                      icon: Icon(
                        Icons.file_upload_outlined,
                        color: darkMode ? white : black,
                      ),
                    );
            }),
            IconButton(
              onPressed: () {
                ref.read(notesNotifierProvider.notifier).deleteNote(widget.noteData).then((value) {
                  snackBar(
                    content: "Note Deleted",
                    context: context,
                    backgroundColor: Colors.green,
                  );
                  context.pushReplacementNamed(RouteName.HOMEPAGE);
                });
              },
              tooltip: "Delete Note",
              icon: Icon(
                Icons.delete_outline,
                color: darkMode ? white : black,
              ),
            ),
          ],
        ),
        backgroundColor: darkMode ? black : white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Text(
                "Created: ${widget.noteData.creationDate}",
                style: genStyle(ref).copyWith(
                  color: darkMode ? white : black.withOpacity(0.6),
                  fontStyle: FontStyle.italic,
                  fontSize: 12,
                ),
              ),
            ),
            sizedBoxHeight(3),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Text(
                "Last modified: ${widget.noteData.modifiedDate}",
                style: genStyle(ref).copyWith(
                  color: darkMode ? white : black.withOpacity(0.6),
                  fontStyle: FontStyle.italic,
                  fontSize: 12,
                ),
              ),
            ),
            sizedBoxHeight(10),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Text(
                widget.noteData.title ?? "",
                style: genStyle(ref).copyWith(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            sizedBoxHeight(10),
            Expanded(
                child: SingleChildScrollView(
              padding: const EdgeInsets.only(left: 15, right: 15),
              physics: const BouncingScrollPhysics(),
              child: Text(
                widget.noteData.content ?? "",
                style: genStyle(ref).copyWith(
                  fontSize: 15,
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
