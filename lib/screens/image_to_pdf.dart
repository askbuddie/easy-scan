import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageToPdf extends StatefulWidget {
  @override
  _ImageToPdfState createState() => _ImageToPdfState();
}

class _ImageToPdfState extends State<ImageToPdf> {
  // ignore: prefer_final_fields
  List<File> _images = [];
  final picker = ImagePicker();
  Future getImageFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
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
        itemCount: _images == null ? 0 : _images.length,
        itemBuilder: (context, index) {
          if (_images != null) {
            return Card(
              child: Image.file(
                _images[index],
                fit: BoxFit.cover,
              ),
            );
          }
          return const Center(
            child: Text("Select Image"),
          );
        });
  }
}
