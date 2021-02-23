import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:questwer_flu/controller/create_controller.dart';
import 'package:questwer_flu/theme/size.dart';
import 'package:questwer_flu/util/getx_snack_bar.dart';
import 'package:questwer_flu/widget/title_widget.dart';

import 'my_bottom.dart';
import 'my_slider.dart';
import 'question_bank_textfield.dart';

class CreateQuestionBank extends StatelessWidget {
  CreateController _createController = Get.put(CreateController());

  @override
  Widget build(BuildContext context) {
    return _buildCreateQB();
  }

  Widget _buildCreateQB() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: DefaultSize.defaultPadding * 2,
          vertical: DefaultSize.defaultPadding),
      child: SingleChildScrollView(
        child: Column(
          children: [
            /// instruction
            _buildInstruction(),

            /// choose or form
            AddTextFieldWidget(),

            /// set difficulty
            _buildDifficulty(),

            SizedBox(
              height: DefaultSize.basePadding,
            ),

            MySlider(),

            SizedBox(
              height: DefaultSize.defaultPadding * 4,
            ),

            /// btn
            _buildBtn(),
          ],
        ),
      ),
    );
  }

  Widget _buildInstruction() {
    return TitleWidget(
      Text(
        "Add a description to your new question bank.",
        style: TextStyle(color: Color(0xFF979796), fontSize: 13, height: 1.5),
      ),
      title: "Create Question Bank",
    );
  }

  Widget _buildDifficulty() {
    return TitleWidget(
      Text(
        "Set overall difficulty for your question bank.",
        style: TextStyle(color: Color(0xFF979796), fontSize: 13, height: 1.5),
      ),
      title: "Set Difficulty",
    );
  }

  Widget _buildBtn() {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () async {
        ///效验
        bool isTextNull = _createController.checkQBInputNull();
        print("isTextNull $isTextNull");
        if (isTextNull) {
          GetXSnackBar().noFillForm();
          return;
        }

        if (_createController.difficulty == "") {
          GetXSnackBar().noTellMeDifficulty();
          return;
        }

        String inputName = _createController.inputTitleController.text.trim();
        String inputDesc = _createController.inputDescController.text.trim();
        bool isCreateSuccess =
            await _createController.createQuestionBank(inputName, inputDesc);
        if (isCreateSuccess) {
          _createController.clearQuestionBankInput();
          _createController.nextPage(!isTextNull);
        } else {
          GetXSnackBar().netError();
        }
      },
      child: MyBottom(
        text: "Continue",
      ),
    );
  }

}
