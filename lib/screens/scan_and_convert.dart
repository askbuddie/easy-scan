import 'package:EasyScan/Utils/constants.dart';
import 'package:EasyScan/controllers/scan_and_convert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScanAndConvert extends StatelessWidget {
  final _scanAndConvertController = Get.put(ScanAndConvertController())
    ..getImageFromSource();

  Widget get getBody {
    if (_scanAndConvertController.hasNotPickedImage) {
      return Center(
        child: RaisedButton(
          textColor: Colors.white,
          onPressed: () => _scanAndConvertController.getImageFromSource(),
          child: const Text('Open Camera'),
        ),
      );
    }
    if (_scanAndConvertController.imageFile == null) {
      return const Center(
          child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
      ));
    } else {
      return Image.file(_scanAndConvertController.imageFile);
    }
  }

  @override
  Widget build(BuildContext context) {
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
