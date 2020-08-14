import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageToPdf extends StatefulWidget {
  @override
  _ImageToPdfState createState() => _ImageToPdfState();
}

class _ImageToPdfState extends State<ImageToPdf> {
  List<File> _images = [];
  ImagePicker _picker = ImagePicker();
  Future getImageFromGallery() async {
    final PickedFile pickedFile =
        await _picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null && pickedFile.path != "") {
      setState(() {
        _images.add(File(pickedFile.path));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getImageFromGallery();
        },
        child: const Icon(Icons.add_a_photo),
      ),
      appBar: AppBar(
        title: const Text('Choose Image'),
      ),
      body: _buildImageList(context),
    );
  }

  Widget _buildImageList(BuildContext context) {
    return GridView.builder(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemCount: _images.length,
        itemBuilder: (context, index) {
          return Card(
            child: Image.file(
              _images[index],
              fit: BoxFit.cover,
            ),
          );
        });
  }
}
