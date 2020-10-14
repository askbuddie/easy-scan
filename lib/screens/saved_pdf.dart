import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';

import 'package:EasyScan/Utils/constants.dart';
import 'package:EasyScan/controllers/saved_pdf.dart';

class SavedPdfScreen extends StatelessWidget {
  final savedPdfController = Get.find<SavedPdfController>();
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
    final fileSystemEntitys = savedPdfController.fileSystemEntitys;
    if (!savedPdfController.isFilesChecked) {
      return const Center(child: CircularProgressIndicator());
    } else if (fileSystemEntitys.isEmpty) {
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
          //TODO:make better card
          return GestureDetector(
            onTap: () => OpenFile.open(fileSystemEntitys[i].path),
            child: Container(
                color: primaryColor.withOpacity(0.2),
                margin: const EdgeInsets.all(10),
                height: 200,
                width: 200,
                child: Center(child: Text("Pdf #${i + 1}"))),
          );
        },
        itemCount: fileSystemEntitys.length,
      );
    }
  }
}
