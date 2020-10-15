import 'package:EasyScan/Utils/constants.dart';
import 'package:EasyScan/Utils/methods.dart';
import 'package:EasyScan/screens/home.dart';
import 'package:EasyScan/widgets/sharedel_dialogue.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:EasyScan/controllers/pdf.dart';

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
              onLongPress: () {
                showDialog(
                    context: _,
                    child: SimpleDialog(
                      title: const Text("What do you want to do ?"),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      children: [
                        SimpleDialogOption(
                          onPressed: () {
                            _savedPdfController.share(index: i);
                          },
                          child: const ShareDelOption(
                            color: primaryColor,
                            title: "Share",
                            iconData: Icons.share,
                          ),
                        ),
                        SimpleDialogOption(
                          onPressed: () {
                            _savedPdfController.refreshFiles();
                            _savedPdfController.deleteFile(i);
                            showToast("Pdf has been deleted");
                            Get.to(HomeScreen());
                          },
                          child: const ShareDelOption(
                              color: Colors.red,
                              title: "Delete",
                              iconData: Icons.delete_outline_sharp),
                        )
                      ],
                    ));
              },
              onTap: () => OpenFile.open(_fileSystemEntitys[i].path),
              child: pdfs[i]);
        },
        itemCount: _fileSystemEntitys.length,
      );
    }
  }
}
