import 'dart:io';
import 'package:flutter/material.dart';
import 'package:preggo/models/user.dart';
import 'package:printing/printing.dart';
import 'makepdf.dart';

class PdfPreviewPage extends StatelessWidget {
  static final id = 'pdfpreviewscreen';

  final UserData userData;
  const PdfPreviewPage({Key? key, required this.userData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Preview'),
      ),
      body: PdfPreview(
        build: (context) => makePdf(userData),
      ),
    );
  }
}
