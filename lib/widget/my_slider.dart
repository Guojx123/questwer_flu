import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:questwer_flu/controller/create_controller.dart';
import 'package:questwer_flu/theme/color.dart';
import 'package:questwer_flu/theme/size.dart';

class MySlider extends StatefulWidget {
  @override
  _MySliderState createState() => _MySliderState();
}

class _MySliderState extends State<MySlider> {
  double _sliderValue = 0.0;
  CreateController _createController = Get.put(CreateController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
            _createController.setDifficulty(_getDifficulty(_sliderValue.toString()));
          },
        ),
      ),
    );
  }

  String _getDifficulty(String num) {
    switch (num) {
      case "0.0":
        return "createQB.slider_easy".tr;
        break;
      case "25.0":
        return "createQB.slider_average".tr;
        break;
      case "50.0":
        return "createQB.slider_medium".tr;
        break;
      case "75.0":
        return "createQB.slider_difficult".tr;
        break;
      case "100.0":
        return "createQB.slider_hell".tr;
        break;
      default:
        return "createQB.slider_unknown".tr;
        break;
    }
  }
}
