import 'package:flutter/material.dart';

Row optionRow({IconData iconData, String title, Color color}) => Row(
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
