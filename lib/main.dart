import 'package:EasyScan/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'Utils/constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EasyScan',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: primaryColor,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: primaryColor,
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
    );
  }
}
