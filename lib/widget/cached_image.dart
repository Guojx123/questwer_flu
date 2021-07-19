import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:questwer_flu/theme/color.dart';
import 'package:questwer_flu/theme/size.dart';
import 'package:questwer_flu/util/transparent_image.dart';

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
      this.placeHolderWidth,
      this.placeHolderHeight,
      this.padding = defaultPadding,
      @required this.url,
      this.fit = BoxFit.fitWidth,
      this.color = rTagGreyColor});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
        height: height,
        width: width,
        // color: color,
        fadeOutDuration: Duration(microseconds: 300),
        imageUrl: url,
        placeholder: (context, url) => Image.memory(kTransparentImage),
        errorWidget: (context, url, error) => Center(child: Icon(Icons.error)),
        fit: fit);
  }
}
