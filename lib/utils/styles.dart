import 'package:flutter/material.dart';

class Styles {
  static Color sunRed = const Color(0xFFEC5939);
  static Color pink = const Color(0xFFF2D9CA);
  static Color grey = const Color(0xFFC9CBCD);
  static Color black = const Color(0xFF000000);

  static tabTextStyle() => const TextStyle(
        color: Colors.black,
      );

  static AppbarTitleTextStyle() => const TextStyle(
      color: Colors.black, fontSize: 25, fontWeight: FontWeight.w200);

  static homeTitleTextStyle() => const TextStyle(
      color: Colors.black, fontSize: 25, fontWeight: FontWeight.w200);

  static myButtonTextStyle() => const TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.w400,
      );

  static normalTextStyle() => const TextStyle(
      color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400);

  static smallTextStyle() => const TextStyle(
      color: Colors.black, fontSize: 14, fontWeight: FontWeight.w400);
}
