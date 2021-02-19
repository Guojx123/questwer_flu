import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:questwer_flu/controller/question_controller.dart';
import 'package:questwer_flu/theme/color.dart';
import 'package:questwer_flu/theme/size.dart';

class ProgressBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: DefaultSize.defaultPadding),
        child: Container(
          width: double.infinity,
          height: DefaultSize.smallSize * 7,
          decoration: BoxDecoration(
              border: Border.all(
                  color: ColorsTheme.greyBlue,
                  width: DefaultSize.smallSize - 3),
              borderRadius: BorderRadius.circular(DefaultSize.smallSize * 8)),
          child: GetBuilder<QuestionController>(
              init: QuestionController(),
              builder: (controller) {
                double timestamp = controller.animation.value;
                return Stack(
                  children: [
                    LayoutBuilder(
                      builder: (context, constraints) => Container(
                        width: constraints.maxWidth * timestamp,
                        decoration: BoxDecoration(
                            gradient: ColorsTheme.kCardGradient,
                            borderRadius: BorderRadius.circular(
                                DefaultSize.smallSize * 8)),
                      ),
                    ),
                    Positioned.fill(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: DefaultSize.defaultPadding),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${(timestamp * 60).round()} sec",
                              style: TextStyle(color: ColorsTheme.greyWhite),
                            ),
                            Icon(
                              Icons.alarm,
                              color: ColorsTheme.greyBlue,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }),
        ));
  }
}
