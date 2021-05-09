import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:questwer_flu/controller/create_controller.dart';
import 'package:questwer_flu/theme/color.dart';
import 'package:questwer_flu/theme/size.dart';
import 'package:get_storage/get_storage.dart';

class MyTextField extends StatelessWidget {
  final int maxLines;
  final int minLines;
  final TextEditingController inputController;
  final TextInputType textInputType;
  final String hintText;
  final double hintTextSize;

  const MyTextField({
    Key key,
    this.maxLines = 1,
    this.minLines = 1,
    @required this.inputController,
    this.textInputType = TextInputType.multiline,
    this.hintText = 'Please enter.',
    this.hintTextSize = 14.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CreateController _createController = Get.put(CreateController());

    /// 解决：删除时，输入框光标位置不正确
    _createController.iniStateTextController(inputController);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: DefaultSize.defaultPadding),
      child: TextField(
        keyboardType: textInputType,
        controller: inputController,
        maxLines: maxLines,
        minLines: minLines,
        cursorColor: rTextColor,
        cursorWidth: 2,
        onChanged: (value) {
          _createController.setText(value, inputController);
        },
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: rTagGreyColor,
            fontSize: hintTextSize,
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          isDense: true,
          border: OutlineInputBorder(
            gapPadding: 0,
            borderRadius: BorderRadius.all(Radius.circular(12)),
            // borderSide: BorderSide(
            //   width: 0.1,
            //   color: Colors.transparent,
            //   style: BorderStyle.none,
            // ),
          ),
        ),
      ),
    );
  }
}
