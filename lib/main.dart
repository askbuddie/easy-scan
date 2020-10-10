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
      debugShowCheckedModeBanner: false,
      title: 'EasyScan',
      theme: ThemeData(
        primaryColor: secondaryColor,
        backgroundColor: Colors.white38,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
    );
  }
}
