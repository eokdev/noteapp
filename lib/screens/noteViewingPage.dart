import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:noteapp/constants/appColors.dart';
import 'package:noteapp/constants/styleConst.dart';
import 'package:noteapp/models/noteDataModel.dart';
import 'package:noteapp/routes/routeNames.dart';
import 'package:noteapp/screens/editNotePage.dart';
import 'package:noteapp/services/noteDataManagement.dart';
import 'package:noteapp/utils/dateLogics.dart';
import 'package:noteapp/utils/snackbars.dart';
import 'package:noteapp/widgets/spacing.dart';

class NoteViewingPage extends ConsumerStatefulWidget {
  final NoteDataModel noteData;
  const NoteViewingPage({super.key, required this.noteData});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NoteViewingPageState();
}

class _NoteViewingPageState extends ConsumerState<NoteViewingPage> {
  @override
  Widget build(BuildContext context) {
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
                ref.read(genNoteData.notifier).state = widget.noteData;

                context.pushReplacementNamed(
                  RouteName.EDITPAGE,
                  extra: widget.noteData,
                );
              },
              tooltip: "Edit Note",
              icon: const Icon(
                Icons.mode_edit_outlined,
                color: black,
              ),
            ),
            IconButton(
              onPressed: () {},
              tooltip: "Share",
              icon: const Icon(
                Icons.file_upload_outlined,
                color: black,
              ),
            ),
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
              icon: const Icon(
                Icons.delete_outline,
                color: black,
              ),
            ),
          ],
        ),
        backgroundColor: white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Text(
                "Created: ${formatMyDate(widget.noteData.creationDate ?? DateTime.now())}",
                style: genStyle(ref).copyWith(
                  color: black.withOpacity(0.6),
                  fontStyle: FontStyle.italic,
                  fontSize: 12,
                ),
              ),
            ),
            sizedBoxHeight(3),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Text(
                "Modified: ${formatMyDate(widget.noteData.modifiedDate ?? DateTime.now())}",
                style: genStyle(ref).copyWith(
                  color: black.withOpacity(0.6),
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
