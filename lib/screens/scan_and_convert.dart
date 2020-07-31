import 'dart:io';

import 'package:EasyScan/Utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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

  void _showImagePicker() async {
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          contentPadding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              height: 35,
              color: Theme.of(context).primaryColor,
              child: Text(
                'Choose Source',
                style: text_style.copyWith(
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            ListTile(
              onTap: _getImageFromSource,
              leading: Icon(Icons.camera_alt),
              title: Text("From Camera"),
            ),
            ListTile(
                onTap: () {
                  _getImageFromSource(ImageSource.gallery);
                },
                leading: Icon(Icons.image),
                title: Text("From Gallery")),
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: const Radius.circular(20.0),
                bottomRight: const Radius.circular(20.0)),
          ),
        );
      },
    );
  }

  void _getImageFromSource([ImageSource source]) async {
    Navigator.pop(context);
    var _pickedFile =
        await ImagePicker().getImage(source: source ?? ImageSource.camera);
    if (_pickedFile != null) {
      setState(() {
        this._imageFile = File(_pickedFile.path);
      });
    }
  }
}
