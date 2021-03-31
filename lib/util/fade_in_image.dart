import 'package:flutter/material.dart';

import 'transparent_image.dart';

class DeckFadeInImage extends StatelessWidget {
  final String imgUrl;
  final num imgWidth;
  final num imgHeight;

  DeckFadeInImage(this.imgUrl, {this.imgWidth,this.imgHeight});

  @override
  Widget build(BuildContext context) {
    return FadeInImage.memoryNetwork(
      image: imgUrl,
      width: imgWidth?.toDouble(),
      height: imgHeight?.toDouble(),
      fit: BoxFit.cover,
      placeholder: kTransparentImage,
      fadeInDuration: Duration(milliseconds: 300),
    );
  }
}
