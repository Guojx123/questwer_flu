import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:questwer_flu/controller/create_controller.dart';
import 'package:questwer_flu/page/home/question_bank_page.dart';
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
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: (){
                    print("返回到上一页，修改题库");
                  },
                  child: Icon(
                    Icons.logout,
                    color: rDeepPurpleColor,
                    size: DefaultSize.smallSize * 6,
                  ),
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
                  ///计算用户创建的题目数
                  Get.dialog(
                      Material(
                        color: Colors.transparent,
                        child: Center(
                            child: Container(
                          height: DefaultSize.middleSize * 20,
                          margin: EdgeInsets.symmetric(
                              horizontal: DefaultSize.defaultPadding * 2),
                          padding: EdgeInsets.only(
                              top: DefaultSize.defaultPadding * 3,
                              bottom: DefaultSize.defaultPadding * 2,
                              right: DefaultSize.defaultPadding * 2,
                              left: DefaultSize.defaultPadding * 2),
                          decoration: BoxDecoration(
                              color: kMilkWhiteColor,
                              borderRadius: BorderRadius.circular(25)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "createQ.dialog_title".tr,
                                style: TextStyle(
                                  fontSize: DefaultSize.middleFontSize * 1.2,
                                  color: rDeepRedColor,
                                ),
                              ),
                              SizedBox(
                                height: DefaultSize.defaultPadding * 2,
                              ),
                              Text(
                                "createQ.dialog_context".tr,
                                maxLines: 2,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: DefaultSize.smallFontSize * 1.2,
                                  color: rBlueColor,
                                ),
                              ),
                              SizedBox(
                                height: DefaultSize.defaultPadding * 2.5,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  GestureDetector(
                                      onPanDown: (_) {
                                        // 用于取消 note 输入框的焦点
                                        FocusScope.of(context).unfocus();
                                      },
                                      behavior: HitTestBehavior.translucent,
                                      onTap: () {
                                        Get.back();
                                      },
                                      child: Icon(
                                        Icons.close_rounded,
                                        size: DefaultSize.middleSize * 3,
                                      )),
                                  GestureDetector(
                                      onPanDown: (_) {
                                        // 用于取消 note 输入框的焦点
                                        FocusScope.of(context).unfocus();
                                      },
                                      behavior: HitTestBehavior.translucent,
                                      onTap: () {
                                        Get.back();
                                        Get.back();
                                      },
                                      child: Icon(
                                        Icons.outdoor_grill,
                                        size: DefaultSize.middleSize * 3,
                                      )),
                                ],
                              ),
                            ],
                          ),
                        )),
                      ),
                      barrierDismissible: false,
                      barrierColor: rBlueColor2C);
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
