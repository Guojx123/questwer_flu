import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:questwer_flu/theme/color.dart';
import 'package:questwer_flu/theme/size.dart';

class TitleWidget extends StatelessWidget {
  final Widget content;
  final String title;
  final double horizontalMargin;
  final bool isCircle;

  const TitleWidget(this.content,
      {Key key, this.title, this.isCircle = true, this.horizontalMargin = 0.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildTitleWidget(content, title: title);
  }

  Widget _buildTitleWidget(Widget content, {String title}) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(
          horizontal: horizontalMargin /2,
          vertical: DefaultSize.defaultPadding * 2),
      padding: EdgeInsets.symmetric(
          horizontal: DefaultSize.defaultPadding,
          vertical: DefaultSize.defaultPadding),
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.6),
          borderRadius:
              BorderRadius.all(isCircle ? Radius.circular(10) : Radius.zero)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$title",
            style: TextStyle(
                height: 1.6,
                color: ColorsTheme.black,
                fontSize: DefaultSize.middleFontSize,
                fontWeight: FontWeight.w500),
          ),
          content
        ],
      ),
    );
  }
}
