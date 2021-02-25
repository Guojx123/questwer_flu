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
        "createQB.title_desc".tr,
        style: TextStyle(color: Color(0xFF979796), fontSize: 13, height: 1.5),
      ),
      title: "createQB.title".tr,
    );
  }

  Widget _buildDifficulty() {
    return TitleWidget(
      Text(
        "createQB.set_difficulty_title_desc".tr,
        style: TextStyle(color: Color(0xFF979796), fontSize: 13, height: 1.5),
      ),
      title: "createQB.set_difficulty_title".tr,
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

        intervalClick(2);

      },
      child: MyBottom(
        text: "createQB.continue".tr,
      ),
    );
  }

  var lastPopTime = DateTime.now();

  void intervalClick(int needTime) async {
    // 重复提交
    if(lastPopTime == null || DateTime.now().difference(lastPopTime) > Duration(seconds: needTime)){
      print(lastPopTime);
      lastPopTime = DateTime.now();
      print("允许点击");
      // 开始提交数据
      String inputName = _createController.inputTitleController.text.trim();
      String inputDesc = _createController.inputDescController.text.trim();
      bool isCreateSuccess =
          await _createController.createQuestionBank(inputName, inputDesc);
      if (isCreateSuccess) {
        _createController.clearQuestionBankInput();
        _createController.nextPage();
      } else {
        GetXSnackBar().netError();
      }
      // 提交完
    }else{
      // lastPopTime = DateTime.now(); //如果不注释这行,则强制用户一定要间隔2s后才能成功点击. 而不是以上一次点击成功的时间开始计算.
      print("请勿重复点击！");
    }
  }
}
