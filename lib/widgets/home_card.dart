import 'package:EasyScan/Utils/constants.dart';
import 'package:flutter/material.dart';

class HomeCard extends StatelessWidget {
  final String text;
  final IconData iconData;
  final Function onTap;
  const HomeCard({Key key, @required this.text, this.iconData, this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: secondaryColor),
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height / 6,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                iconData,
                color: Colors.white,
                size: 50,
              ),
              Text(
                text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 25,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
