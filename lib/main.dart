import 'package:EasyScan/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:EasyScan/Utils/constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EasyScan',
      theme: ThemeData(
        buttonTheme: ButtonThemeData(
          buttonColor: primaryColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        ),
        primaryColor: primaryColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
    );
  }
}
