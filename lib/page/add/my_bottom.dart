import 'package:flutter/material.dart';
import 'package:questwer_flu/theme/color.dart';
import 'package:questwer_flu/theme/size.dart';

class MyBottom extends StatelessWidget {

  final String text;

  const MyBottom({Key key, this.text = "unknow"}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: DefaultSize.defaultPadding * 8,
          vertical: DefaultSize.defaultPadding * 1.4),
      decoration: BoxDecoration(
        borderRadius:
        BorderRadius.circular(DefaultSize.largeSize / 2),
        color: rTextWhiteColor,
      ),
      child: Text(
        "$text",
        style: TextStyle(
          color:  rDeepPurpleColor ,
          fontSize: DefaultSize.smallFontSize,
        ),
      ),
    );
  }
}
