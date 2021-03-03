import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:questwer_flu/theme/color.dart';
import 'package:questwer_flu/theme/size.dart';

class CachedImage extends StatelessWidget {
  final double width;
  final double height;
  final double padding;
  final String url;
  final double placeHolderWidth;
  final double placeHolderHeight;
  final Color color;
  final BoxFit fit;

  CachedImage(
      {this.width,
      this.height,
      this.placeHolderWidth = 200,
      this.placeHolderHeight,
      this.padding = 10,
      @required this.url,
      this.fit = BoxFit.fitWidth,
      this.color = rTagGreyColor});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
        height: height,
        width: width,
        // color: color,
        fadeOutDuration: Duration(microseconds: 100),
        imageUrl: url,
        placeholder: (context, url) => Container(
              color: color,
              padding: EdgeInsets.all(DefaultSize.largeSize),
              child: Center(
                  child: Image.asset(
                'assets/uikit_bg.png',
                width: placeHolderWidth,
                height: placeHolderHeight,
                fit: BoxFit.fitWidth,
              )),
            ),
        errorWidget: (context, url, error) => Icon(Icons.error),
        fit: fit);
  }
}
