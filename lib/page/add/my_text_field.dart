import 'package:flutter/material.dart';
import 'package:questwer_flu/service/my_text_editing_controller.dart';
import 'package:questwer_flu/theme/color.dart';
import 'package:questwer_flu/theme/size.dart';

class MyTextField extends StatelessWidget {
  final int maxLines;
  final int minLines;
  final TextEditingController inputController;
  final TextInputType textInputType;

  const MyTextField(
      {Key key,
      this.maxLines = 1,
      this.minLines = 1,
      @required this.inputController,
      this.textInputType = TextInputType.multiline})
      : super(key: key);

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
        decoration: const InputDecoration(
          hintText: 'Please enter.',
          hintStyle: TextStyle(color: rTagGreyColor),
          filled: true,
          fillColor: rTextWhiteColor4B,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          isDense: true,
          border: const OutlineInputBorder(
            gapPadding: 0,
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(
              width: 1,
              color: rPinkColor,
              style: BorderStyle.none,
            ),
          ),
        ),
      ),
    );
  }
}
