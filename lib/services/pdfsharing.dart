// ignore_for_file: deprecated_member_use

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:path_provider/path_provider.dart';

import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';

class ShareServices {
  Future<String> exportAndSharePdf(ShareResModel model) async {
    try {
      final pdf = pw.Document();
      pdf.addPage(
        pw.Page(
          build: (pw.Context context) {
            return pw.Column(
              children: [
                pw.Paragraph(
                  text: model.title,
                  style: const pw.TextStyle(fontSize: 24),
                ),
                pw.Paragraph(text: model.quillDelta),
              ],
            );
          },
        ),
      );

      final pdfBytes = await pdf.save();

      await saveAndLaunchFileForShare(pdfBytes, "Notes.pdf");
      return "Yes";
    } catch (e) {
      return "No";
    }
  }
}

final shareProviderRes = StateProvider.autoDispose<String?>((ref) => null);
final shareProvider = Provider<ShareServices>((ref) => ShareServices());

final share = FutureProvider.family<String, ShareResModel>(
  (ref, arg) async {
    final shareRes = await ref.read(shareProvider).exportAndSharePdf(arg);
    final isDone = shareRes == "Yes";
    if (isDone) {
      ref.read(shareProviderRes.notifier).state = shareRes;
    } else {
      ref.read(shareProviderRes.notifier).state = shareRes;
    }
    return "Yes";
  },
);

Future<void> saveAndLaunchFileForShare(List<int> bytes, String fileName) async {
  final dir = await getApplicationDocumentsDirectory();
  final file = File('${dir.path}/$fileName');
  await file.writeAsBytes(bytes, flush: true);
  Share.shareFiles([file.path], text: "Notes.pdf");
}

class ShareResModel {
  final BuildContext? context;
  final String? quillDelta;
  final String? title;

  ShareResModel(this.context, this.quillDelta, this.title);
}
