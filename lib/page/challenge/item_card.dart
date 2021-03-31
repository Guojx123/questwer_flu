import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:questwer_flu/theme/size.dart';
import 'package:questwer_flu/util/fade_in_image.dart';
import 'package:questwer_flu/widget/cached_image.dart';

class ItemCard extends StatelessWidget {
  final img; //图片
  final title; //图标下文字
  final icon; //是否有图标
  final double height;
  final bool flag; //true阴影

  ItemCard(this.img, this.height,
      {this.title = "", this.icon, this.flag = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: DefaultSize.defaultPadding,
          vertical: DefaultSize.defaultPadding),
      child: Stack(
        children: <Widget>[
          ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Stack(
                children: <Widget>[
                  // DeckFadeInImage(this.img,
                  //   imgHeight: double.infinity,
                  //   imgWidth: double.infinity,
                  // ),
                  CachedImage(
                    url: this.img ??
                        "https://cdnimg.doutian.me/20210227/66341614400745168?imageMogr2/auto-orient",
                    fit: BoxFit.cover,
                    height: double.infinity,
                    width: double.infinity,
                  ),
                  this.flag
                      ? BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 0.1, sigmaY: 0.1),
                          child: Container(
                            color: Colors.black.withOpacity(0.3),
                          ),
                        )
                      : Container()
                ],
              )),
          Positioned(
            left: 20,
            top: 20,
            child: Icon(
              this.icon,
              color: Colors.white,
              size: 32,
            ),
          ),
          Positioned(
              left: 20,
              top: 52,
              child: Text(this.title,
                  maxLines: 2,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: DefaultSize.middleFontSize - 4,
                      fontWeight: FontWeight.w500)))
        ],
      ),
    );
  }
}
