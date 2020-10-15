import 'package:flutter/material.dart';

class SimpleDlgOption extends StatelessWidget {
  final String title;
  final Color color;
  final IconData iconData;
  const SimpleDlgOption({
    this.title,
    this.color,
    this.iconData,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.delete_outline_sharp,
          color: color,
        ),
        const SizedBox(
          width: 20,
        ),
        Text(title)
      ],
    );
  }
}
