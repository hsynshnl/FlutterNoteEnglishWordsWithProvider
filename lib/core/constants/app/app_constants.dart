import 'package:flutter/material.dart';

class AppConstants {
  static const Color backgroundColor = Colors.white;
  static const Color textColor = Color(0xff232323);
  static const Color borderColor = Color.fromARGB(255, 15, 15, 15);
  static const Color buttonTextColor = Color(0xff9FC131);
  static const TextStyle boxTextStyle = TextStyle(
    color: AppConstants.textColor,
    fontSize: 20,
    fontWeight: FontWeight.w500,
    letterSpacing: 1.2,
  );
  static BoxDecoration boxDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(15),
    color: AppConstants.backgroundColor,
    border: Border.all(
      color: AppConstants.borderColor,
      width: 2,
      style: BorderStyle.solid,
    ),
  );
}
