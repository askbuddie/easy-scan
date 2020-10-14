import 'dart:io';
import 'package:get/get.dart';
import 'package:EasyScan/Utils/methods.dart';
import 'package:image_picker/image_picker.dart';

class ScanAndConvertController extends GetxController {
  final _hasNotPickedImage = false.obs;
  final _imageFile = Rx<File>();

  bool get hasNotPickedImage => _hasNotPickedImage.value;
  File get imageFile => _imageFile.value;

  Future<void> getImageFromSource() async {
    _hasNotPickedImage.value = false;
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
