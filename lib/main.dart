import 'package:flutter/material.dart';
import 'package:EasyScan/Utils/constants.dart';
import 'package:EasyScan/screens/home_screen.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EasyScan',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(color: primaryColor),
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
