import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:EasyScan/Utils/constants.dart' show textStyle;

class ScanAndConvert extends StatefulWidget {
  @override
  _ScanAndConvertState createState() => _ScanAndConvertState();
}

class _ScanAndConvertState extends State<ScanAndConvert> {
  @override
  Widget build(BuildContext context) {
    //TODO:implement this
    return Container();
  }

  // ignore: unused_field
  File _imageFile;

  Future<void> _showImagePicker() async {
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          contentPadding: EdgeInsets.zero,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0)),
          ),
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              height: 35,
              color: Theme.of(context).primaryColor,
              child: Text(
                'Choose Source',
                style: textStyle.copyWith(
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            ListTile(
              onTap: _getImageFromSource,
              leading: const Icon(Icons.camera_alt),
              title: const Text("From Camera"),
            ),
            ListTile(
                onTap: () {
                  _getImageFromSource(ImageSource.gallery);
                },
                leading: const Icon(Icons.image),
                title: const Text("From Gallery")),
          ],
        );
      },
    );
  }

  Future<void> _getImageFromSource([ImageSource source]) async {
    Navigator.pop(context);
    final _pickedFile =
        await ImagePicker().getImage(source: source ?? ImageSource.camera);
    if (_pickedFile != null) {
      setState(() {
        _imageFile = File(_pickedFile.path);
      });
    }
  }
}
