import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:EasyScan/Utils/constants.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:flutter/material.dart' as material;
import 'package:EasyScan/Utils/permission_checker.dart';

Future cropImage(String imagepath, Function(String) onCrop) async {
  final File croppedFile = await ImageCropper.cropImage(
      sourcePath: imagepath,
      aspectRatioPresets: Platform.isAndroid
          ? [
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio16x9
            ]
          : [
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio5x3,
              CropAspectRatioPreset.ratio5x4,
              CropAspectRatioPreset.ratio7x5,
              CropAspectRatioPreset.ratio16x9
            ],
      androidUiSettings: const AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          toolbarColor: primaryColor,
          toolbarWidgetColor: material.Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false),
      iosUiSettings: const IOSUiSettings(
        title: 'Crop Image',
      ));
  if (croppedFile != null) {
    onCrop(croppedFile.path);
  }
}

void exportPdf(List<File> images) {
  final Document pdf = Document();
  //TODO:make better ui
  pdf.addPage(MultiPage(
      pageFormat: PdfPageFormat.a4.copyWith(
        marginBottom: 1 * PdfPageFormat.cm,
        marginLeft: 1 * PdfPageFormat.cm,
        marginTop: 1 * PdfPageFormat.cm,
        marginRight: 1 * PdfPageFormat.cm,
      ),
      header: (Context context) {
        return Center(
            child: Text(
          'Easy scan',
          style: const TextStyle(fontSize: 30, color: PdfColors.purple),
        ));
      },
      footer: (Context context) {
        return Container(
          alignment: Alignment.centerRight,
          child: Text(
            'Page ${context.pageNumber}',
            style: Theme.of(context)
                .defaultTextStyle
                .copyWith(color: PdfColors.grey),
          ),
        );
      },
      build: (Context context) => <Widget>[
            for (var i = 0; i < images.length; i++)
              Image(
                  PdfImage.file(
                    pdf.document,
                    bytes: images[i].readAsBytesSync(),
                  ),
                  height: 500)
          ]));
  savePdf(pdf);
}

Future<String> savePdf(Document pdf) async {
  //this supports only android currently
  final bool permission = await permision.checkPermission();
  if (!permission) {
    await permision.requestPermission();
  } else {
    final Directory appDocDir = Directory(pdfPathAndroid);
    final bool hasExisted = await appDocDir.exists();
    if (!hasExisted) {
      appDocDir.create();
    }
    final now = DateTime.now().millisecondsSinceEpoch.toString();
    final File file = File('${appDocDir.path}/${now.substring(9)}.pdf');
    await file.create(recursive: true);
    final data = pdf.save();
    await file.writeAsBytes(data);
    return file.path;
  }
  return null;
}
