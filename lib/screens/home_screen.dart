
import 'package:EasyScan/Utils/constants.dart';
import 'package:EasyScan/screens/image_to_pdf.dart';
import 'package:EasyScan/screens/scan_and_convert.dart';
import 'package:EasyScan/widgets/home_card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // ignore: unused_field
  

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EasyScan'),
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
            textStyle: textStyle.copyWith(
              fontSize: 20,
            ),
          ),
          HomeCard(
            onTap: ()=> Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ImageToPdf(),
                ),
              ),
            iconData: Icons.picture_as_pdf,
            color: Colors.green,
            text: 'Image to pdf',
            textStyle: textStyle.copyWith(fontSize: 20),
          ),
        ],
      ),
    );
  }
}
