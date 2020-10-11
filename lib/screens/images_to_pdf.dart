import 'dart:io';

import 'package:EasyScan/Utils/constants.dart';
import 'package:EasyScan/Utils/methods.dart';

import 'package:flutter/material.dart';

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
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FloatingActionButton.extended(
            onPressed: () {
              (_images.isNotEmpty)
                  ? exportPdf(_images)
                  : showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return SimpleDialog(
                          title: const Text("Please select some images first."),
                          children: [
                            SimpleDialogOption(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text("OK"),
                            )
                          ],
                        );
                      });
            },
            backgroundColor: primaryColor,
            splashColor: secondaryColor,
            elevation: 8.0,
            icon: const Icon(Icons.upload_file),
            label: const Text(
              'Export',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w700),
            ),
          ),
        ),
        appBar: AppBar(
          title: const Text(
            'Choose Image',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
                icon: const Icon(Icons.add), onPressed: getImageFromGallery)
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              CheckboxListTile(
                  checkColor: secondaryColor,
                  title: const Text('Crop Image',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
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
        ));
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
