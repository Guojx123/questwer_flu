import 'dart:ui';

import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  final img; //图片
  final title; //图标下文字
  final icon; //是否有图标
  final double height;
  final bool flag; //true无阴影

  ItemCard(this.img, this.height,
      {this.title = "", this.icon, this.flag = false});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        height: this.height,
        child: Column(
          children: <Widget>[
            Container(
              height: flag ? null : this.height,
              child: Stack(
                children: <Widget>[
                  ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Stack(
                        children: <Widget>[
                          Image.asset(
                            this.img,
                            fit: BoxFit.cover,
                            height: this.height,
                            width: double.infinity,
                          ),
                          BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 0.5, sigmaY: 0.5),
                            child: Container(
                              color: Colors.black.withOpacity(0.3),
                            ),
                          )
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
                    child: Text(
                      this.title,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
