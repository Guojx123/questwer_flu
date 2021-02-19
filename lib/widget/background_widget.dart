import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

class BackGroundWidget extends StatelessWidget {

  final double blur;
  final Color bgColor;

  BackGroundWidget({
    Key key,
    this.blur = 0.0, this.bgColor = Colors.blueGrey,
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
        size: 0.4,
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
