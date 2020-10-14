import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:EasyScan/controllers/scan_and_convert.dart';
import 'package:EasyScan/Utils/constants.dart';

class ScanAndConvert extends StatelessWidget {
  final scanAndConvertController = Get.put(ScanAndConvertController());

  Widget get getBody {
    if (scanAndConvertController.hasNotPickedImage) {
      return Center(
        child: RaisedButton(
          textColor: Colors.white,
          onPressed: () => scanAndConvertController.getImageFromSource(),
          child: const Text('Open Camera'),
        ),
      );
    }
    if (scanAndConvertController.imageFile == null) {
      return const Center(
          child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
      ));
    } else {
      return Image.file(scanAndConvertController.imageFile);
    }
  }

  @override
  Widget build(BuildContext context) {
    scanAndConvertController.getImageFromSource();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text(
          'Image to convert',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Obx(() => getBody),
    );
  }
}
