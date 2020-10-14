import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:EasyScan/Utils/methods.dart';

class ScanAndConvertController extends GetxController {
  final _hasNotPickedImage = false.obs;
  final _imageFile = Rx<File>();

  File get imageFile => _imageFile.value;
  bool get hasNotPickedImage => _hasNotPickedImage.value;

  Future<void> getImageFromSource() async {
    final PickedFile _pickedFile =
        await ImagePicker().getImage(source: ImageSource.camera);
    if (_pickedFile != null) {
      cropImage(_pickedFile.path, (path) {
        _hasNotPickedImage.value = false;
        _imageFile.value = File(path);
        // TODO:send to editing page (first make one)
      });
    } else {
      _hasNotPickedImage.value = true;
    }
  }
}
