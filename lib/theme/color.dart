import 'package:flutter/material.dart';

class ColorsTheme {

  static Color get black => Color(0xFF000000);
  static Color get white => Color(0xFFffffff);
  static Color get primaryColor => Color(0xFF56b0ba);

  static Gradient get kPrimaryGradient => LinearGradient(
        colors: [Color(0xFF46A0AE), Color(0xFF00FFCB)],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      );

  static Gradient get kWelcomeGradient => LinearGradient(
        colors: [Colors.cyan, Colors.teal],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      );
}
