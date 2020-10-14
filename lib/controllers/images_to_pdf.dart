import 'dart:io';
import 'package:get/get.dart';
import 'package:EasyScan/Utils/methods.dart';
import 'package:image_picker/image_picker.dart';

class ImageToPdfController extends GetxController {
  final shouldCropImage = false.obs;
  final _images = <File>[].obs;
  final ImagePicker _picker = ImagePicker();
  RxList<File> get images => _images;

  void addImage(String path) => _images.add(File(path));

  void exportToPdf() => exportPdf(images);
  Future<void> getImageFromGallery() async {
    final PickedFile pickedFile =
        await _picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null && pickedFile.path != "") {
      if (shouldCropImage.value) {
        cropImage(pickedFile.path, (path) {
          addImage(path);
        });
      } else {
        addImage(pickedFile.path);
      }
    }
  }

  void removeImage(int index) => _images.removeAt(index);
}
