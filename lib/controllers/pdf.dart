import 'dart:io' as dd;
import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:EasyScan/Utils/constants.dart';
import 'package:EasyScan/widgets/history_card.dart';
import 'package:EasyScan/Utils/permission_checker.dart';
import 'package:native_pdf_renderer/native_pdf_renderer.dart';

class PdfController extends GetxController {
  final _isFilesChecked = false.obs;
  final fileSystemEntitys = <dd.FileSystemEntity>[].obs;
  List<Widget> _pdfWidgets;
  dd.Directory _savedDir;

  bool get isFilesChecked => _isFilesChecked.value;
  List<Widget> get pdfs => _pdfWidgets;
  @override
  void onInit() {
    _getPaths();
  }

  void refreshFiles() {
    _getPaths();
  }

  Future<void> _getFileList() async {
    if (_savedDir != null) {
      fileSystemEntitys.value = _savedDir.listSync();
      _isFilesChecked.value = true;
    }
    await _makeWidgetList();
  }

  Future<void> _getPaths() async {
    final _per = await permision.checkPermission();
    if (_per) {
      _savedDir = dd.Directory(pdfPathAndroid);
      final _exist = await _savedDir.exists();
      if (_exist) await _getFileList();
    }
  }

  Future<void> _makeWidgetList() async {
    _pdfWidgets = [];
    for (final dd.FileSystemEntity file in fileSystemEntitys) {
      final Uint8List resolvedData = dd.File(file.path).readAsBytesSync();
      if (resolvedData != null) {
        final PdfDocument document = await PdfDocument.openData(resolvedData);
        final PdfPage page = await document.getPage(1);
        final PdfPageImage pageImage =
            await page.render(width: page.width, height: page.height);

        _pdfWidgets.add(HistoryCard(pageImage: pageImage, file: file));
      } else {
        _pdfWidgets.add(
          Container(
            color: primaryColor.withOpacity(0.2),
            margin: const EdgeInsets.all(10),
            height: 200,
            width: 200,
            child: Center(
              child: Text(
                basename(file.path),
              ),
            ),
          ),
        );
      }
    }
  }
}
