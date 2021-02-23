import 'package:flutter/material.dart';
import 'package:questwer_flu/theme/size.dart';

class PageWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imgUrl;
  final onTap;

  PageWidget(this.title, this.subtitle, this.imgUrl, this.onTap);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        margin: EdgeInsets.symmetric(
          vertical: DefaultSize.defaultPadding,
          horizontal: DefaultSize.defaultPadding,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Image.asset(imgUrl,fit: BoxFit.contain),
            Spacer(),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: DefaultSize.middleSize * 4,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Spacer(),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                subtitle,
                style: TextStyle(
                  fontSize: DefaultSize.middleSize * 1.8,
                ),
              ),
            ),
            Spacer(),
          ],
        ),
      ),
      onTap: onTap,
    );
  }
}
