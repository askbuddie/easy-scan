import 'dart:io';

import 'package:EasyScan/Utils/constants.dart';
import 'package:EasyScan/screens/image_to_pdf.dart';
import 'package:EasyScan/screens/scan_and_convert.dart';
import 'package:EasyScan/widgets/home_card.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // ignore: unused_field
  File _image;
  final picker = ImagePicker();
  Future getImageFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedFile.path);
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('EasyScan'),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 5,
        children: [
          HomeCard(
            onTap: () => Navigator.push(
                context, MaterialPageRoute(builder: (_) => ScanAndConvert())),
            iconData: Icons.broken_image,
            color: Colors.red,
            text: 'Scan and convert',
            textStyle: text_style.copyWith(
              fontSize: 20,
            ),
          ),
          HomeCard(
            onTap: () {
              getImageFromGallery().then((value) {
                if (_image == null) {
                  // handling error in home_screen
                  print('No I image selected');
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ImageToPdf(
                        galleryimage: _image,
                      ),
                    ),
                  );
                }
              });
            },
            iconData: Icons.picture_as_pdf,
            color: Colors.green,
            text: 'Image to pdf',
            textStyle: text_style.copyWith(fontSize: 20),
          ),
        ],
      ),
    );
  }
}
