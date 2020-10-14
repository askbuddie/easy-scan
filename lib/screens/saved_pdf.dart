import 'dart:io' as dd;
import 'package:flutter/material.dart';
import 'package:EasyScan/Utils/constants.dart';
import 'package:EasyScan/Utils/permission_checker.dart';
import 'package:open_file/open_file.dart';
import 'package:share/share.dart';

class SavedPdfScreen extends StatefulWidget {
  @override
  _SavedPdfScreenState createState() => _SavedPdfScreenState();
}

class _SavedPdfScreenState extends State<SavedPdfScreen> {
  List<dd.FileSystemEntity> _fileSystemEntitys = [];
  dd.Directory _savedDir;
  Future<void> deleteFile({int index}) async {
    final String filename = _fileSystemEntitys[index]
        .toString()
        .split('/')[4]
        .toString()
        .split("'")[0];
    try {
      final file = dd.File('storage/emulated/0/Easy Scan/$filename');
      if (await file.exists()) {
        await file.delete(recursive: true);
      }
    } catch (e) {
      // error in getting access to the file
    }
  }

  void share(int index) {
    final String filename = _fileSystemEntitys[index]
        .toString()
        .split('/')[4]
        .toString()
        .split("'")[0];
    Share.shareFiles(['storage/emulated/0/Easy Scan/$filename'], text: 'mypdf');
  }

//currrently supports only android
  Future<void> _getPaths() async {
    final _per = await permision.checkPermission();
    if (_per) {
      _savedDir = dd.Directory(pdfPathAndroid);
      setState(() {});
      final _exist = await _savedDir.exists();
      if (_exist) await _getFileList();
    }
  }

  Future<void> _getFileList() async {
    if (_savedDir != null) {
      _fileSystemEntitys = _savedDir.listSync();
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    _getPaths();
  }

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
    if (_fileSystemEntitys == null) {
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
          //TODO:make better card
          return GestureDetector(
            onTap: () => OpenFile.open(_fileSystemEntitys[i].path),
            onLongPress: () {
              showDialog(
                context: _,
                builder: (context) => SimpleDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  children: [
                    SimpleDialogOption(
                      onPressed: () {
                        share(i);
                      },
                      child: Row(
                        children: const [
                          Icon(
                            Icons.share,
                            color: primaryColor,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text("Share"),
                        ],
                      ),
                    ),
                    SimpleDialogOption(
                      onPressed: () {
                        deleteFile(index: i);
                        Navigator.of(context).pop();
                        Navigator.pop(context);
                      },
                      child: Row(
                        children: const [
                          Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text("Delete"),
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
            child: Container(
                color: primaryColor.withOpacity(0.2),
                margin: const EdgeInsets.all(10),
                height: 200,
                width: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Icon(
                      Icons.picture_as_pdf_sharp,
                      color: primaryColor,
                      size: 45,
                    ),
                    Center(child: Text("Pdf #${i + 1}")),
                  ],
                )),
          );
        },
        itemCount: _fileSystemEntitys.length,
      );
    }
  }
}
