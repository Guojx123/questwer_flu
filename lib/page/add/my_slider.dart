import 'package:flutter/material.dart';
import 'package:questwer_flu/theme/color.dart';
import 'package:questwer_flu/theme/size.dart';

class MySlider extends StatefulWidget {
  @override
  _MySliderState createState() => _MySliderState();
}

class _MySliderState extends State<MySlider> {
  double _sliderValue = 0.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: DefaultSize.defaultPadding),
      child: SliderTheme(
        data: SliderTheme.of(context).copyWith(
          valueIndicatorShape: PaddleSliderValueIndicatorShape(),
        ),
        child: Slider(
          activeColor: rDeepPurpleColor,
          inactiveColor: rLightPurpleColor,
          value: _sliderValue,
          label: '${_getDifficulty(_sliderValue.toString())}',
          min: 0,
          max: 100,
          divisions: 4,
          onChanged: (v) {
            setState(() {
              _sliderValue = v;
            });
          },
        ),
      ),
    );
  }

  String _getDifficulty(String num) {
    switch (num) {
      case "0.0":
        return "easy";
        break;
      case "25.0":
        return "average";
        break;
      case "50.0":
        return "medium";
        break;
      case "75.0":
        return "difficult";
        break;
      case "100.0":
        return "hell";
        break;
      default:
        return "unknown";
        break;
    }
  }
}
