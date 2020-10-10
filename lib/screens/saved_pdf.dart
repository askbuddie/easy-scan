import 'dart:io' as dd;
import 'package:flutter/material.dart';
import 'package:EasyScan/Utils/constants.dart';
import 'package:EasyScan/Utils/permission_checker.dart';
import 'package:open_file/open_file.dart';

class SavedPdfScreen extends StatefulWidget {
  @override
  _SavedPdfScreenState createState() => _SavedPdfScreenState();
}

class _SavedPdfScreenState extends State<SavedPdfScreen> {
  List<dd.FileSystemEntity> _fileSystemEntitys = [];
  dd.Directory _savedDir;
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
            child: Container(
                color: primaryColor.withOpacity(0.2),
                margin: const EdgeInsets.all(10),
                height: 200,
                width: 200,
                child: Center(child: Text("Pdf #${i + 1}"))),
          );
        },
        itemCount: _fileSystemEntitys.length,
      );
    }
  }
}
