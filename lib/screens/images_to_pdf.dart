import 'package:EasyScan/Utils/methods.dart';
import 'package:EasyScan/screens/home.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:EasyScan/Utils/constants.dart';
import 'package:EasyScan/controllers/images_to_pdf.dart';

class ImageToPdf extends StatelessWidget {
  final _imageToPdfController = Get.put(ImageToPdfController());
  @override
  Widget build(BuildContext context) {
    final _images = _imageToPdfController.images;
    return Scaffold(
        floatingActionButton: Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (_images.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: FloatingActionButton.extended(
                      heroTag: 'export',
                      onPressed: () {
                        _imageToPdfController.exportToPdf();
                        showToast("Pdf has been created");
                        Get.to(HomeScreen());
                      },
                      icon: const Icon(Icons.upload_file),
                      label: const Text('Export'),
                      backgroundColor: Colors.green,
                    ),
                  ),
                FloatingActionButton.extended(
                  heroTag: 'addimg',
                  onPressed: _imageToPdfController.getImageFromGallery,
                  icon: const Icon(Icons.add),
                  label: const Text('Add image'),
                ),
              ],
            )),
        appBar: AppBar(
          title: const Text(
            'Choose Image',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Obx(() => CheckboxListTile(
                  checkColor: secondaryColor,
                  title: const Text('Crop Image',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                  value: _imageToPdfController.shouldCropImage.value,
                  onChanged: (crop) {
                    _imageToPdfController.shouldCropImage.value = crop;
                  })),
              Obx(() => Expanded(child: _buildImageList(_images))),
              //TODO:make ui better
            ],
          ),
        ));
  }

  Widget _buildImageList(RxList images) {
    if (images.isEmpty) {
      return const Center(
        child: Text('Insert a Image'),
      );
    }
    return GridView.builder(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemCount: images.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onLongPress: () {},
            child: Stack(fit: StackFit.expand, children: [
              Card(
                child: Image.file(
                  images[index],
                  fit: BoxFit.fill,
                ),
              ),
              Positioned(
                right: 0,
                child: IconButton(
                  icon: const Icon(
                    Icons.close,
                    size: 25,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    _imageToPdfController.removeImage(index);
                  },
                ),
              )
            ]),
          );
        });
  }
}
