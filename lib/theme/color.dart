import 'package:flutter/material.dart';

const kSecondaryColor = Color(0xFF8B94BC);
const kGreenColor = Color(0xFF6AC259);
const kRedColor = Color(0xFFE92E30);
const kGrayColor = Color(0xFF5c5c5c);
const kWhiteColor = Color(0xFFf8f8f8);
const kMilkWhiteColor = Color(0xFFf8f8f8);
const kBlackColor = Color(0xFF101010);

const rTagGreyColor = Color(0xFF636E84);
const rCloseGreyColor = Color(0xFFB0B2ED);
const rTextColor = Color(0xFF797BCE);
const rTextWhiteColor = Color(0xFFE2E1F3);
const rTextWhiteColor4B = Color(0x4bE2E1F3);
const rTextWhiteColor20 = Color(0x20E2E1F3);

const rBlueColor = Color(0xFF393A59);
const rBlueColor2C = Color(0x2C393A59);
const rLightBlueColor = Color(0xFF6976B9);
const rMiddleBlueColor = Color(0xFF6060A0);

const rPurpleColor = Color(0xFF8287E2);
const rLightPurpleColor = Color(0xFFABADEF);
const rMiddlePurpleColor = Color(0xFF8B91E5);
const rMiddlePurpleColorE6 = Color(0xE68B91E5);
const rMiddlePurpleColor2B = Color(0x2B8B91E5);
const rDeepPurpleColor = Color(0xFF525487);

const rPinkColor = Color(0xFFE660A0);
const rYellowColor = Color(0xFFffff00);
const rOrangeColor = Color(0xFFFF6730);
const rDeepRedColor = Color(0xFFbf3130);

class ColorsTheme {
  static Color get black => Color(0xFF000000);

  static Color get white => Color(0xFFffffff);

  static Color get grey => Color(0xffb8b8b8);

  static Color get greyWhite => Color(0xFFf7f7f7);

  static Color get greyBlue => Color(0xFF3f4768);

  static Color get lightBlue => Color(0xff52abbe);

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
        colors: [Color(0xdd0991b5), Color(0xdd7939f1)],
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
        colors: [Color(0x50632587), Color(0x88872c25)],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      );

  static Gradient get rCardGradient => LinearGradient(
        colors: [Color(0x4347e2c6), Color(0x979193EF)],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      );

  static Gradient get aCardGradient => LinearGradient(
        colors: [Colors.blueGrey, Color(0x979193EF)],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      );

  static Gradient get bCardGradient => LinearGradient(
        colors: [Color(0x600991b5), Color(0x90993c25)],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      );

  static Gradient get rBackgroundGradient => LinearGradient(
        colors: const [Colors.blueAccent, Colors.deepOrangeAccent],
        stops: const [0.0, 1.0],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      );
}
