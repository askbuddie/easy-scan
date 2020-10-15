import 'package:flutter/material.dart';

class ShareDelOption extends StatelessWidget {
  final IconData iconData;
  final String title;
  final Color color;
  const ShareDelOption({Key key, this.iconData, this.title, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          iconData,
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
