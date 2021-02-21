import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:questwer_flu/controller/create_controller.dart';
import 'package:questwer_flu/theme/color.dart';
import 'package:questwer_flu/theme/size.dart';
import 'add_question_bank_page.dart';
import 'add_question_page.dart';

class AddPageView extends StatelessWidget {
  CreateController _createController = Get.put(CreateController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// tag icon
        Container(
          margin:
              EdgeInsets.symmetric(vertical: DefaultSize.defaultPadding * 1.2),
          decoration: BoxDecoration(
              color: rTagGreyColor,
              borderRadius: BorderRadius.circular(DefaultSize.middleSize)),
          width: DefaultSize.largeSize,
          height: DefaultSize.smallSize,
        ),

        /// topNav
        Container(
          margin: EdgeInsets.symmetric(
              horizontal: DefaultSize.defaultPadding * 1.2,
              vertical: DefaultSize.middleSize),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(DefaultSize.smallSize * 1.2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(DefaultSize.middleSize),
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
                    borderRadius: BorderRadius.circular(DefaultSize.middleSize),
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
              CreateQuestionBank(),
              CreateQuestion(),
            ],
          ),
        ),
      ],
    );
  }
}
