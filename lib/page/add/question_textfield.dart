import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:questwer_flu/controller/create_controller.dart';
import 'package:questwer_flu/theme/color.dart';
import 'package:questwer_flu/theme/size.dart';
import 'package:questwer_flu/widget/amount_textfield.dart';

import 'my_text_field.dart';

/// a 选择题
/// 1.题目标题、描述
class NQuestionTextFieldWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreateController>(
        init: CreateController(),
        builder: (controller) {
          return Theme(
            data: ThemeData(primaryColor: rLightBlueColor),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                MyTextField(
                  maxLines: 2,
                  minLines: 1,
                  inputController: controller.inputNQTitleController,
                  hintText: "Title...",
                  hintTextSize: 18.0,
                ),
                MyTextField(
                  maxLines: 6,
                  minLines: 3,
                  inputController: controller.inputNQDescController,
                  hintText: "Add some description...",
                  hintTextSize: 16.0,
                ),
              ],
            ),
          );
        });
  }
}

/// 2.题目选项
class NQuestionOptionTextFieldWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreateController>(
        init: CreateController(),
        builder: (controller) {
          return Theme(
            data: ThemeData(primaryColor: rLightBlueColor),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: AmountTextField(
                    controller: controller.inputOtherFAnswerController,
                    labelText: "Option 1",
                  ),
                ),
                SizedBox(
                  width: DefaultSize.defaultPadding,
                ),
                Expanded(
                  child: AmountTextField(
                    controller: controller.inputOtherSAnswerController,
                    labelText: "Option 2",
                  ),
                ),
                SizedBox(
                  width: DefaultSize.defaultPadding,
                ),
                Expanded(
                  child: AmountTextField(
                    controller: controller.inputOtherTAnswerController,
                    labelText: "Option 3",
                  ),
                ),
              ],
            ),
          );
        });
  }
}

/// 3.题目正确答案
class NQuestionCorrectAnswerTextFieldWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreateController>(
        init: CreateController(),
        builder: (controller) {
          return Theme(
            data: ThemeData(primaryColor: rLightBlueColor),
            child: AmountTextField(
              controller: controller.inputCorrectAnswerController,
              labelText: "Correct Answer",
            ),
          );
        });
  }
}

/// b 判断题
class BQuestionTextFieldWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreateController>(
        init: CreateController(),
        builder: (controller) {
          return Theme(
            data: ThemeData(primaryColor: rLightBlueColor),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                MyTextField(
                  maxLines: 2,
                  minLines: 1,
                  inputController: controller.inputBQTitleController,
                  hintText: "Title...",
                  hintTextSize: 18.0,
                ),
                MyTextField(
                  maxLines: 6,
                  minLines: 3,
                  inputController: controller.inputBQDescController,
                  hintText: "Add some description...",
                  hintTextSize: 16.0,
                ),
              ],
            ),
          );
        });
  }
}