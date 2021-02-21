import 'package:flutter/material.dart';
import 'package:questwer_flu/theme/size.dart';
import 'package:simple_animations/simple_animations.dart';

class BackGroundWidget extends StatelessWidget {
  final double blur;
  final Color bgColor;
  final double size;

  BackGroundWidget({
    Key key,
    this.blur = 0.0,
    this.bgColor = Colors.blueGrey,
    this.size = smallSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xff00123d),
        backgroundBlendMode: BlendMode.srcOver,
      ),
      child: PlasmaRenderer(
        type: PlasmaType.infinity,
        particles: 12,
        color: bgColor,
        blur: blur,
        size: size,
        speed: 0.2,
        offset: 0,
        blendMode: BlendMode.screen,
        variation1: 0,
        variation2: 0,
        variation3: 0,
        rotation: 1,
      ),
    );
  }
}

class GradientBackGroundWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          tileMode: TileMode.mirror,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xff0fbcdf),
            Color(0xff03203e),
          ],
          stops: [
            0,
            1,
          ],
        ),
        backgroundBlendMode: BlendMode.srcOver,
      ),
      child: PlasmaRenderer(
        type: PlasmaType.infinity,
        particles: 14,
        color: Color(0x44ffffff),
        blur: 0.16,
        size: 0.21,
        speed: 0.91,
        offset: 1.3,
        blendMode: BlendMode.screen,
        variation1: 0.31,
        variation2: 0.3,
        variation3: 0.13,
        rotation: -0.79,
      ),
    );
  }
}
