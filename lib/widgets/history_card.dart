import 'dart:io' as dd;
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:native_pdf_renderer/native_pdf_renderer.dart';

class HistoryCard extends StatelessWidget {
  const HistoryCard({
    Key key,
    @required this.pageImage,
    @required this.file,
  }) : super(key: key);

  final PdfPageImage pageImage;
  final dd.FileSystemEntity file;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 250, minHeight: 200),
      child: Card(
        elevation: 3,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Image.memory(
                pageImage.bytes,
                fit: BoxFit.fitWidth,
                width: 200,
                filterQuality: FilterQuality.none,
              ),
            ),
            Text(basename(file.path))
          ],
        ),
      ),
    );
  }
}
