import 'dart:io';
import 'package:flutter/material.dart';
import 'package:EasyScan/Utils/methods.dart';
import 'package:image_picker/image_picker.dart';

class ImageToPdf extends StatefulWidget {
  @override
  _ImageToPdfState createState() => _ImageToPdfState();
}

class _ImageToPdfState extends State<ImageToPdf> {
  final List<File> _images = [];
  final ImagePicker _picker = ImagePicker();
  Future getImageFromGallery() async {
    final PickedFile pickedFile =
        await _picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null && pickedFile.path != "") {
      if (_cropImage) {
        cropImage(pickedFile.path, (path) {
          addImage(path);
        });
      } else {
        addImage(pickedFile.path);
      }
    }
  }

  void addImage(String path) => setState(() {
        _images.add(File(path));
      });
  bool _cropImage = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (_images.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: FloatingActionButton.extended(
                heroTag: 'export',
                onPressed: () => exportPdf(_images),
                icon: const Icon(Icons.upload_file),
                label: const Text('Export'),
                backgroundColor: Colors.green,
              ),
            ),
          FloatingActionButton.extended(
            heroTag: 'addimg',
            onPressed: getImageFromGallery,
            icon: const Icon(Icons.add),
            label: const Text('Add image'),
          ),
        ],
      ),
      appBar: AppBar(
        title: const Text('Images to Pdf'),
      ),
      body: Column(
        children: [
          CheckboxListTile(
              title: const Text('Crop Image'),
              value: _cropImage,
              onChanged: (crop) {
                setState(() {
                  _cropImage = crop;
                });
              }),
          Expanded(child: _buildImageList(context)),
          //TODO:make ui better
        ],
      ),
    );
  }

  Widget _buildImageList(BuildContext context) {
    if (_images.isEmpty) {
      return const Center(
        child: Text('Insert a Image'),
      );
    }
    return GridView.builder(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemCount: _images.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onLongPress: () {},
            child: Stack(fit: StackFit.expand, children: [
              Card(
                child: Image.file(
                  _images[index],
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
                    _images.removeAt(index);
                    setState(() {});
                  },
                ),
              )
            ]),
          );
        });
  }
}
