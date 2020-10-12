import 'dart:io';

import 'package:EasyScan/Utils/constants.dart';
import 'package:EasyScan/Utils/methods.dart';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

class ScanAndConvert extends StatefulWidget {
  @override
  _ScanAndConvertState createState() => _ScanAndConvertState();
}

class _ScanAndConvertState extends State<ScanAndConvert> {
  bool _hasNotPickedImage = false;
  Widget get getBody {
    if (_hasNotPickedImage) {
      return Center(
        child: RaisedButton(
          textColor: Colors.white,
          onPressed: () => _getImageFromSource(),
          child: const Text('Open Camera'),
        ),
      );
    }
    if (_imageFile == null) {
      return const Center(
          child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
      ));
    } else {
      return Image.file(_imageFile);
    }
  }

  File _imageFile;

  @override
  void initState() {
    super.initState();
    _getImageFromSource();
  }

  Future<void> _getImageFromSource() async {
    final PickedFile _pickedFile =
        await ImagePicker().getImage(source: ImageSource.camera);
    if (_pickedFile != null) {
      cropImage(_pickedFile.path, (path) {
        _imageFile = File(path);
        //TODO:send to editing page (first make one)
      });
    } else {
      _hasNotPickedImage = true;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text(
          'Image to convert',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: getBody,
    );
  }
}
