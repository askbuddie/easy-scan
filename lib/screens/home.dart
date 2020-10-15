import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:EasyScan/Utils/constants.dart';
import 'package:EasyScan/screens/history.dart';
import 'package:EasyScan/widgets/home_card.dart';
import 'package:EasyScan/screens/images_to_pdf.dart';
import 'package:EasyScan/screens/scan_and_convert.dart';

class HomeScreen extends StatelessWidget {
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
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
          const Spacer(),
          Container(
            color: primaryColor,
            child: const Text(
              //TODO:use package info to get actual version and build number
              'V1.0(1)',
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
