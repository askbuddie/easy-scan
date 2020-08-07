import 'package:flutter/material.dart';

class HomeCard extends StatelessWidget {
  final Color color;
  final String text;
  final TextStyle textStyle;
  final IconData iconData;
  final Function onTap;
  const HomeCard(
      {Key key,
      @required this.text,
      this.color,
      this.textStyle,
      this.iconData,
      this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: color ?? Colors.red.withOpacity(0.6),
        ),
        alignment: Alignment.center,
        height: 100,
        width: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (iconData != null)
              Icon(
                iconData,
                color: Colors.white,
                size: 45,
              ),
            Text(
              text,
              textAlign: TextAlign.center,
              style: textStyle,
            ),
          ],
        ),
      ),
    );
  }
}
