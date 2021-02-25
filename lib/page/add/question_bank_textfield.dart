import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:questwer_flu/controller/create_controller.dart';
import 'package:questwer_flu/theme/color.dart';
import 'my_text_field.dart';

class AddTextFieldWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreateController>(
        init: CreateController(),
        builder: (controller) {
          return Theme(
            data: new ThemeData(primaryColor: rLightBlueColor),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                MyTextField(
                  maxLines: 2,
                  minLines: 1,
                  inputController: controller.inputTitleController,
                  hintText: "Title...",
                  hintTextSize: 18.0,
                ),
                MyTextField(
                  maxLines: 8,
                  minLines: 4,
                  inputController: controller.inputDescController,
                  hintText: "Add some description...",
                  hintTextSize: 16.0,
                ),
              ],
            ),
          );
        });
  }
}
