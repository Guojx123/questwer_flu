import 'package:flutter/material.dart';

const kSecondaryColor = Color(0xFF8B94BC);
const kGreenColor = Color(0xFF6AC259);
const kRedColor = Color(0xFFE92E30);
const kGrayColor = Color(0xFF5c5c5c);
const kWhiteColor = Color(0xFFffffff);
const kBlackColor = Color(0xFF101010);

class ColorsTheme {

  static Color get black => Color(0xFF000000);
  static Color get white => Color(0xFFffffff);
  static Color get primaryColor => Color(0xFF56b0ba);
  static Color get tealBtnColor => Color(0xFF22ddCB);

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

  static Gradient get gWelcomeGradient => LinearGradient(
    colors: [Color(0x880991b5), Color(0x9956b0ba)],
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
    colors: [Color(0x600991b5),Color(0x90993c25)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
}
