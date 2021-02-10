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

  static Gradient get kCardGradient => LinearGradient(
    colors: [Color(0xFF0991b5), Color(0xFF56b0ba)],
    end: Alignment.centerLeft,
    begin: Alignment.centerRight,
  );

  static Gradient get kWelcomeGradient => LinearGradient(
        colors: [Colors.cyan, Colors.teal],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      );

  static Gradient get gCardGradient => LinearGradient(
    colors: [Color(0x50632587),Color(0x88872c25)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static Gradient get rCardGradient => LinearGradient(
    colors: [Color(0x600991b5),Color(0x90872c25)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
}
