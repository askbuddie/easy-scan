import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:EasyScan/controllers/saved_pdf.dart';

class SavedPdfScreen extends StatelessWidget {
  final _savedPdfController = Get.find<PdfController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
      ),
      body: getBody,
    );
  }

  Widget get getBody {
    final _fileSystemEntitys = _savedPdfController.fileSystemEntitys;
    final pdfs = _savedPdfController.pdfs;
    if (!_savedPdfController.isFilesChecked) {
      return const Center(child: CircularProgressIndicator());
    } else if (_fileSystemEntitys.isEmpty) {
      return const Center(
        child: Text(
          'No history found',
          textAlign: TextAlign.center,
        ),
      );
    } else {
      return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 4, mainAxisSpacing: 4),
        itemBuilder: (_, i) {
          return GestureDetector(
              onTap: () => OpenFile.open(_fileSystemEntitys[i].path),
              child: pdfs[i]);
        },
        itemCount: _fileSystemEntitys.length,
      );
    }
  }
}
