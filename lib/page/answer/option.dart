import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:questwer_flu/controller/question_controller.dart';
import 'package:questwer_flu/theme/color.dart';
import 'package:questwer_flu/theme/size.dart';

class Option extends StatelessWidget {
  const Option({
    Key key,
    this.text,
    this.index,
    this.press,
  }) : super(key: key);
  final String text;
  final int index;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuestionController>(
        init: QuestionController(),
        builder: (qnController) {
          Color getTheRightColor() {
            if (qnController.isAnswered) {
              if (text == qnController.correctAns) {
                return kGreenColor;
              } else if (text == qnController.selectedAns &&
                  qnController.selectedAns != qnController.correctAns) {
                return kRedColor;
              }
            }
            return kGrayColor;
          }

          IconData getTheRightIcon() {
            return getTheRightColor() == kRedColor ? Icons.close : Icons.done;
          }

          return GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: qnController.isAnswered ? () {} : press,
            // onTap: press,
            child: Container(
              margin: EdgeInsets.only(top: DefaultSize.defaultPadding * 2),
              padding: EdgeInsets.all(DefaultSize.defaultPadding),
              decoration: BoxDecoration(
                  border: qnController.isAnswered
                      ? Border.all(color: getTheRightColor())
                      : Border.all(color: kWhiteColor),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: ColorsTheme.greyWhite,
                        offset: Offset(2.0, 6.0), //阴影xy轴偏移量
                        blurRadius: 10.0, //阴影模糊程度
                        spreadRadius: 3.0 //阴影扩散程度
                        )
                  ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${index + 1}. $text",
                    style: TextStyle(color: getTheRightColor(), fontSize: 16),
                  ),
                  Container(
                    height: 26,
                    width: 26,
                    decoration: BoxDecoration(
                      color: getTheRightColor() == kGrayColor
                          ? Colors.transparent
                          : getTheRightColor(),
                      borderRadius: BorderRadius.circular(50),
                      border: !qnController.isAnswered
                          ? Border.all(color: ColorsTheme.grey)
                          : Border.all(color: ColorsTheme.greyWhite),
                    ),
                    child: getTheRightColor() == kGrayColor
                        ? null
                        : Icon(
                            getTheRightIcon(),
                            size: 16,
                            color: ColorsTheme.white,
                          ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
