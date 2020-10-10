import 'package:EasyScan/Utils/constants.dart';
import 'package:EasyScan/screens/images_to_pdf.dart';
import 'package:EasyScan/screens/scan_and_convert.dart';
import 'package:EasyScan/widgets/home_card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text("Easy Scan"),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          HomeCard(
            onTap: () => Navigator.push(
                context, MaterialPageRoute(builder: (_) => ScanAndConvert())),
            iconData: Icons.image_search,
            color: Colors.red,
            text: 'Scan and convert',
          ),
          HomeCard(
            onTap: () => Navigator.push(
                context, MaterialPageRoute(builder: (_) => ImageToPdf())),
            iconData: Icons.picture_as_pdf_outlined,
            color: Colors.green,
            text: 'Images to Pdf',
          ),
        ],
      ),
    );
  }
}
