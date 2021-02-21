import 'package:flutter/material.dart';
import 'package:questwer_flu/theme/color.dart';
import 'package:questwer_flu/theme/size.dart';

/// 信息输入框封装
class AmountTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String prefixText;
  final String suffixText;

  const AmountTextField(
      {Key key,
      this.controller,
      this.labelText,
      this.prefixText,
      this.suffixText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        keyboardType: TextInputType.text,
        controller: controller,
        cursorColor: rTextColor,
        cursorWidth: 1,
//          inputFormatters: [
//          WhitelistingTextInputFormatter(RegExp("[a-zA-Z0-9]")),   //限制只允许输入字母和数字
//            WhitelistingTextInputFormatter.digitsOnly,         //限制只允许输入数字
//            LengthLimitingTextInputFormatter(6),               //限制输入长度不超过6位
//          ],
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: rTagGreyColor),
            ),
            focusColor: rTagGreyColor,
            labelText: labelText ?? "",
            labelStyle: TextStyle(fontSize: DefaultSize.smallFontSize),
            prefixText: prefixText ?? "",
            suffixText: suffixText ?? "",
            suffixStyle: TextStyle(
                color: rTextColor, fontSize: DefaultSize.smallFontSize)),
        validator: (value) {
          return value.trim().length > 0 ? null : "not null";
        });
  }
}
