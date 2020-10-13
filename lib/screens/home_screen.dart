import 'package:EasyScan/screens/saved_pdf.dart';
import 'package:flutter/material.dart';
import 'package:EasyScan/widgets/home_card.dart';
import 'package:EasyScan/screens/images_to_pdf.dart';
import 'package:EasyScan/screens/scan_and_convert.dart';
import 'package:get/get.dart';

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
              onTap: () => Get.to(ScanAndConvert()),
              iconData: Icons.image_search,
              text: 'Scan and convert',
            ),
            HomeCard(
              onTap: () => Get.to(ImageToPdf()),
              iconData: Icons.picture_as_pdf_outlined,
              text: 'Images to Pdf',
            ),
            HomeCard(
              onTap: () => Get.to(SavedPdfScreen()),
              iconData: Icons.save_rounded,
              text: 'History',
            ),
          ]),
    );
  }
}
