import 'package:flutter/material.dart';
import 'package:questwer_flu/service/my_text_editing_controller.dart';
import 'package:questwer_flu/theme/color.dart';
import 'package:questwer_flu/theme/size.dart';

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
    return Padding(
      padding: EdgeInsets.symmetric(vertical: DefaultSize.defaultPadding),
      child: TextField(
        keyboardType: textInputType,
        controller: inputController,
        maxLines: maxLines,
        minLines: minLines,
        cursorColor: ColorsTheme.primaryColor,
        cursorWidth: 1,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: rTagGreyColor,
            fontSize: hintTextSize,
          ),
          filled: true,
          fillColor: rTextWhiteColor4B,
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
