import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ScanAndConvert extends StatefulWidget {
  @override
  _ScanAndConvertState createState() => _ScanAndConvertState();
}

class _ScanAndConvertState extends State<ScanAndConvert> {
  get getBody {
    if (_imageFile == null)
      return Center(child: CircularProgressIndicator());
    else
      return Image.file(_imageFile);
  }

  File _imageFile;

  @override
  void initState() {
    super.initState();
    _getImageFromSource(ImageSource.gallery);
  }

  Future<void> _getImageFromSource([ImageSource source]) async {
    Navigator.pop(context);
    final PickedFile _pickedFile =
        await ImagePicker().getImage(source: source ?? ImageSource.camera);
    if (_pickedFile != null) {
      setState(() {
        _imageFile = File(_pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody,
    );
  }
}
