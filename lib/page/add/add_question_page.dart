import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:questwer_flu/controller/create_controller.dart';
import 'package:questwer_flu/page/add/my_bottom.dart';
import 'package:questwer_flu/theme/color.dart';
import 'package:questwer_flu/theme/size.dart';
import 'package:questwer_flu/util/getx_snack_bar.dart';
import 'package:questwer_flu/widget/multi_selection_widget.dart';
import 'package:questwer_flu/widget/title_widget.dart';
import 'custom_tab.dart';
import 'question_textfield.dart';

class CreateQuestion extends StatelessWidget {
  CreateController _createController = Get.put(CreateController());

  @override
  Widget build(BuildContext context) {
    return CustomTab(
      leftWidget: _buildCreateNQuestion(),
      rightWidget: _buildCreateBQuestion(),
    );
  }

  /// 创建单项选择题页面
  Widget _buildCreateNQuestion() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: DefaultSize.defaultPadding * 2,
          vertical: DefaultSize.defaultPadding),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _buildCreateQTitle(),
            NQuestionTextFieldWidget(),
            _buildCreateQCorrectAnswer(),
            NQuestionCorrectAnswerTextFieldWidget(),
            _buildCreateNQOption(),
            NQuestionOptionTextFieldWidget(),
            SizedBox(
              height: DefaultSize.defaultPadding * 4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    _createController.clearNQuestionInput();
                  },
                  child: Container(
                    padding: EdgeInsets.all(DefaultSize.smallSize * 1.2),
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(DefaultSize.middleSize),
                      color: rLightPurpleColor,
                    ),
                    child: Container(
                      width: DefaultSize.middleSize * 3.2,
                      height: DefaultSize.middleSize * 3.2,
                      child: Image.asset("assets/icon_clear.png"),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    ///效验
                    bool isTextNull = _createController.checkNQInputNull();
                    if (isTextNull) {
                      GetXSnackBar().noFillForm();
                      return;
                    }
                    intervalClick(2, false);
                  },
                  child: MyBottom(
                    text: "createQ.textfield_create".tr,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  /// 创建判断题页面
  Widget _buildCreateBQuestion() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: DefaultSize.defaultPadding * 2,
          vertical: DefaultSize.defaultPadding),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _buildCreateQTitle(),
            BQuestionTextFieldWidget(),
            _buildCreateQCorrectAnswer(),
            MultiSelectionWidget(
              'Bool',
              [
                "createBQ.button_true".tr,
                "createBQ.button_false".tr,
                "createBQ.button_unknow".tr
              ],
              [
                "createBQ.button_true".tr,
                "createBQ.button_false".tr,
                "createBQ.button_unknow".tr
              ],
              (value) {
                _createController.setSelectValue(value);
              },
            ),
            SizedBox(
              height: DefaultSize.defaultPadding * 4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    _createController.clearBQuestionInput();
                  },
                  child: Container(
                    padding: EdgeInsets.all(DefaultSize.smallSize * 1.2),
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(DefaultSize.middleSize),
                      color: rLightPurpleColor,
                    ),
                    child: Container(
                      width: DefaultSize.middleSize * 3.2,
                      height: DefaultSize.middleSize * 3.2,
                      child: Image.asset("assets/icon_clear.png"),
                    ),
                  ),
                ),
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () async {
                    ///校验
                    bool isTextNull = _createController.checkBQInputNull();
                    if (isTextNull) {
                      GetXSnackBar().noFillForm();
                      return;
                    }
                    intervalClick(2, true);
                  },
                  child: MyBottom(
                    text: "createQ.textfield_create".tr,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  var lastPopTime = DateTime.now();

  void intervalClick(int needTime, isBool) async {
    // 重复提交
    if (lastPopTime == null ||
        DateTime.now().difference(lastPopTime) > Duration(seconds: needTime)) {
      print(lastPopTime);
      lastPopTime = DateTime.now();
      print("允许点击");
      // 开始提交数据
      if (isBool) {
        String inputBQTitle =
            _createController.inputBQTitleController.text.trim();
        String inputBQDesc =
            _createController.inputBQDescController.text.trim();

        bool isCreateSuccess = await _createController.createQuestion(
          inputBQTitle,
          inputBQDesc,
          _createController.selectValue,
          true,
        );
        if (isCreateSuccess) {
          GetXSnackBar().createSuccess();
          _createController.clearBQuestionInput();
        } else {
          GetXSnackBar().netError();
        }
      } else {
        String inputName = _createController.inputNQTitleController.text.trim();
        String inputDesc = _createController.inputNQDescController.text.trim();
        String inputCorrectAnswer =
            _createController.inputCorrectAnswerController.text.trim();

        String firstOption =
            _createController.inputOtherFAnswerController.text.trim();
        String secondOption =
            _createController.inputOtherSAnswerController.text.trim();
        String threeOption =
            _createController.inputOtherTAnswerController.text.trim();

        bool isCreateSuccess = await _createController.createQuestion(
          inputName,
          inputDesc,
          inputCorrectAnswer,
          false,
          firstOption: firstOption,
          secondOption: secondOption,
          threeOption: threeOption,
        );
        if (isCreateSuccess) {
          GetXSnackBar().createSuccess();
          _createController.clearNQuestionInput();
        } else {
          GetXSnackBar().netError();
        }
      }
      // 提交完
    } else {
      // lastPopTime = DateTime.now(); //如果不注释这行,则强制用户一定要间隔2s后才能成功点击. 而不是以上一次点击成功的时间开始计算.
      print("请勿重复点击！");
    }
  }

  Widget _buildCreateQTitle() {
    return TitleWidget(
      Text(
        "createNQ.title_desc".tr,
        style: TextStyle(color: Color(0xFF979796), fontSize: 13, height: 1.5),
      ),
      title: "createNQ.title".tr,
    );
  }

  Widget _buildCreateNQOption() {
    return TitleWidget(
      Text(
        "createNQ.option_desc".tr,
        style: TextStyle(color: Color(0xFF979796), fontSize: 13, height: 1.5),
      ),
      title: "createNQ.option".tr,
    );
  }

  Widget _buildCreateQCorrectAnswer() {
    return TitleWidget(
      Text(
        "createQ.correct_answer_desc".tr,
        style: TextStyle(color: Color(0xFF979796), fontSize: 13, height: 1.5),
      ),
      title: "createQ.correct_answer".tr,
    );
  }
}
