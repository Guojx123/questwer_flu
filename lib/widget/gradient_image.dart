import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:questwer_flu/theme/size.dart';

import 'cached_image.dart';

class GradientImageWidget extends StatelessWidget {
  final num gradientLength;
  final String imageUrl;

  const GradientImageWidget({Key key, this.gradientLength = 10, this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildImage();
  }

  Widget _buildImage() {
    return ShaderMask(
      shaderCallback: (rect) {
        return LinearGradient(
          end: Alignment.centerLeft,
          begin: Alignment.centerRight,
          colors: List<Color>.generate(
            gradientLength,
            (index) => _getColor(index),
          ),
          stops: List<double>.generate(
            gradientLength,
            (index) => _getDouble(index),
          ), //<-- the gradient is interpolated, and these are where the colors above go into effect (that's why there are two colors repeated)
        ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
      },
      blendMode: BlendMode.dstIn,
      child: GetUtils.isURL(imageUrl)
          ? CachedImage(
              url: imageUrl,
              fit: BoxFit.fill,
            )
          : FlutterLogo(
              size: DefaultSize.middleSize * 8,
            ),
    );
  }

  _getColor(int index) {
    double value = index.toDouble() / gradientLength;
    return Colors.black12.withOpacity(1.0 - value);
  }

  _getDouble(int index) {
    double value = ((index.toDouble() / gradientLength));
    return value;
  }
}
