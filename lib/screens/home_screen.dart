import 'package:EasyScan/screens/saved_pdf.dart';
import 'package:flutter/material.dart';
import 'package:EasyScan/widgets/home_card.dart';
import 'package:EasyScan/screens/images_to_pdf.dart';
import 'package:EasyScan/screens/scan_and_convert.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Easy Scan",
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            HomeCard(
              onTap: () => Navigator.push(
                  context, MaterialPageRoute(builder: (_) => ScanAndConvert())),
              iconData: Icons.image_search,
              text: 'Scan and convert',
            ),
            HomeCard(
              onTap: () => Navigator.push(
                  context, MaterialPageRoute(builder: (_) => ImageToPdf())),
              iconData: Icons.picture_as_pdf_outlined,
              text: 'Images to Pdf',
            ),
            HomeCard(
              onTap: () => Navigator.push(
                  context, MaterialPageRoute(builder: (_) => SavedPdfScreen())),
              iconData: Icons.save_rounded,
              text: 'History',
            ),
          ]),
    );
  }
}
