import 'dart:io' as dd;
import 'package:get/get.dart';
import 'package:EasyScan/Utils/constants.dart';
import 'package:EasyScan/Utils/permission_checker.dart';

class SavedPdfController extends GetxController {
  final _isFilesChecked = false.obs;
  final fileSystemEntitys = <dd.FileSystemEntity>[].obs;
  dd.Directory _savedDir;

  bool get isFilesChecked => _isFilesChecked.value;

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
  }

  Future<void> _getPaths() async {
    final _per = await permision.checkPermission();
    if (_per) {
      _savedDir = dd.Directory(pdfPathAndroid);
      final _exist = await _savedDir.exists();
      if (_exist) await _getFileList();
    }
  }
}
