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
            _buildCreateNQTitle(),
            NQuestionTextFieldWidget(),
            _buildCreateNQCorrectAnswer(),
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
                      borderRadius: BorderRadius.circular(DefaultSize.middleSize),
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
                    String inputName = _createController.inputNQTitleController.text.trim();
                    String inputDesc = _createController.inputNQDescController.text.trim();
                    String inputCorrectAnswer = _createController.inputCorrectAnswerController.text.trim();

                    String firstOption = _createController.inputOtherFAnswerController.text.trim();
                    String secondOption = _createController.inputOtherSAnswerController.text.trim();
                    String threeOption = _createController.inputOtherTAnswerController.text.trim();

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
                  },
                  child: MyBottom(
                    text: "Create",
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
            _buildCreateNQTitle(),
            BQuestionTextFieldWidget(),
            _buildCreateNQCorrectAnswer(),
            MultiSelectionWidget(
              'Bool',
              ["true","false","unknow"],
              ["true","false","unknow"],
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
                      borderRadius: BorderRadius.circular(DefaultSize.middleSize),
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
                    String inputBQTitle = _createController.inputBQTitleController.text.trim();
                    String inputBQDesc = _createController.inputBQDescController.text.trim();

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
                  },
                  child: MyBottom(
                    text: "Create",
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildCreateNQTitle() {
    return TitleWidget(
      Text(
        "Add a description to your new question.",
        style: TextStyle(color: Color(0xFF979796), fontSize: 13, height: 1.5),
      ),
      title: "Create Question Title",
    );
  }

  Widget _buildCreateNQOption() {
    return TitleWidget(
      Text(
        "Add options to your new question.",
        style: TextStyle(color: Color(0xFF979796), fontSize: 13, height: 1.5),
      ),
      title: "Question Option (At least three)",
    );
  }

  Widget _buildCreateNQCorrectAnswer() {
    return TitleWidget(
      Text(
        "Add the correct answer to your new question.",
        style: TextStyle(color: Color(0xFF979796), fontSize: 13, height: 1.5),
      ),
      title: "Question Correct Answer (Only one)",
    );
  }
}
