import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:questwer_flu/controller/create_controller.dart';
import 'package:questwer_flu/page/add/my_slider.dart';
import 'package:questwer_flu/theme/color.dart';
import 'package:questwer_flu/theme/size.dart';

import 'question_bank_textfield.dart';

class AddPageView extends StatelessWidget {

  CreateController _createController = Get.put(CreateController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children:[
        /// tag icon
        Container(
          margin: EdgeInsets.symmetric(vertical: DefaultSize.defaultPadding * 1.2),
          decoration: BoxDecoration(
              color: rTagGreyColor,
              borderRadius:
              BorderRadius.circular(DefaultSize.middleSize)),
          width: DefaultSize.largeSize,
          height: DefaultSize.smallSize,
        ),
        /// topNav
        Container(
          margin:
          EdgeInsets.symmetric(horizontal: DefaultSize.defaultPadding* 1.2,vertical: DefaultSize.middleSize),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(DefaultSize.smallSize * 1.2),
                decoration: BoxDecoration(
                  borderRadius:
                  BorderRadius.circular(DefaultSize.middleSize),
                ),
                child: Icon(
                  Icons.read_more,
                  color: rDeepPurpleColor,
                  size: DefaultSize.smallSize * 6,
                ),
              ),
              Text(
                "",
                style: TextStyle(
                    color: rDeepPurpleColor,
                    fontSize: DefaultSize.middleFontSize),
              ),
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  Get.back();
                },
                child: Container(
                  padding: EdgeInsets.all(DefaultSize.smallSize * 1.2),
                  decoration: BoxDecoration(
                    borderRadius:
                    BorderRadius.circular(DefaultSize.middleSize),
                    color: rLightPurpleColor.withOpacity(0.8),
                  ),
                  child: Icon(
                    Icons.close,
                    color: rDeepPurpleColor,
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: PageView(
            physics: NeverScrollableScrollPhysics(),
            controller: _createController.pageController,
            children: [
              _buildCreateQB(),
              _secondPage()
            ],
          ),
        ),
      ] ,
    );
  }

  Widget _buildCreateQB(){
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

            MySlider(),

            SizedBox(
              height: DefaultSize.defaultPadding,
            ),

            /// btn
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                bool isTextNull = _createController.checkInputNull();
                print("$isTextNull sd");
                _createController.nextPage(!isTextNull);
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: DefaultSize.defaultPadding * 8,
                    vertical: DefaultSize.defaultPadding * 1.4),
                decoration: BoxDecoration(
                  borderRadius:
                  BorderRadius.circular(DefaultSize.largeSize / 2),
                  color: rLightPurpleColor.withOpacity(0.8),
                ),
                child: Text(
                  "Continue",
                  style: TextStyle(
                    color: rDeepPurpleColor,
                    fontSize: DefaultSize.smallFontSize,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _secondPage(){
    return Center(
      child: Text("Second Page"),
    );
  }

  Widget _buildInstruction() {
    return _buildTitleWidget(
      Text(
        "Add a description to your new question bank.",
        style: TextStyle(color: Color(0xFF979796), fontSize: 13, height: 1.5),
      ),
      title: "Create Question Bank",
    );
  }

  Widget _buildDifficulty() {
    return _buildTitleWidget(
      Text(
        "Set overall difficulty for your question bank.",
        style: TextStyle(color: Color(0xFF979796), fontSize: 13, height: 1.5),
      ),
      title: "Set Difficulty",
    );
  }

  Widget _buildTitleWidget(Widget content, {String title}) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(vertical: DefaultSize.defaultPadding * 2),
      padding: EdgeInsets.symmetric(
          horizontal: DefaultSize.defaultPadding,
          vertical: DefaultSize.defaultPadding),
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.6),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$title",
            style: TextStyle(
                height: 1.6,
                color: ColorsTheme.black,
                fontSize: DefaultSize.middleFontSize,
                fontWeight: FontWeight.w500),
          ),
          content
        ],
      ),
    );
  }
}
