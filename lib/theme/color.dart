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
  static Color get grey => Color(0xffb8b8b8);
  static Color get greyWhite => Color(0xFFf7f7f7);
  static Color get greyBlue => Color(0xFF3f4768);
  static Color get primaryColor => Color(0xFF56b0ba);
  static Color get teal => Color(0xFF22ddCB);
  static Color get pink => Color(0xDCFD23F3);
  static Color get purple => Color(0x979193EF);

  static Gradient get kPrimaryGradient => LinearGradient(
        colors: [Color(0xFF46A0AE), Color(0xFF00FFCB)],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      );

  static Gradient get gPrimaryGradient => LinearGradient(
    colors: [Color(0xdd0991b5),Color(0xdd7939f1)],
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
    colors: [Color(0x4347e2c6),Color(0x979193EF)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static Gradient get bCardGradient => LinearGradient(
    colors: [Color(0x600991b5),Color(0x90993c25)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

}
