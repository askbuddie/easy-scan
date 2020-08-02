import 'dart:io';

import 'package:flutter/material.dart';

class ImageToPdf extends StatefulWidget {
  final File galleryimage;
  const ImageToPdf({Key key, @required this.galleryimage}) : super(key: key);

  @override
  _ImageToPdfState createState() => _ImageToPdfState();
}

class _ImageToPdfState extends State<ImageToPdf> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: <Widget>[
          Container(
            height: 400,
            width: double.infinity,
            child: Image.file(widget.galleryimage),
          ),
        ],
      ),
    );
  }
}
