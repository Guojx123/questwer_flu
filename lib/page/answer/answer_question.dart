import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';
import 'package:questwer_flu/controller/question_controller.dart';
import 'package:questwer_flu/page/score/score_screen.dart';
import 'package:questwer_flu/theme/color.dart';
import 'package:questwer_flu/theme/size.dart';
import 'package:questwer_flu/widget/background_widget.dart';
import 'package:questwer_flu/widget/common_app_bar.dart';

import 'question_card.dart';

class AnswerQuestion extends StatelessWidget {
  final String name;

  AnswerQuestion({
    Key key,
    this.name,
  }) : super(key: key);

  QuestionController _questionController = Get.put(QuestionController());
  DateTime _lastPressedAt; //上次点击时间

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        body: Stack(
          children: [
            BackGroundWidget(
              blur: 0.0,
            ),
            Column(
              children: [
                CommonAppBar(
                  "",
                  canBack: false,
                  actionWidget: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: DefaultSize.defaultPadding * 3,
                        vertical: DefaultSize.basePadding),
                    child: Text(
                      "Skip",
                      style: TextStyle(
                          color: ColorsTheme.white,
                          fontSize: DefaultSize.fontSize),
                    ),
                  ),
                  actionFunction: () {
                    print("Tips: Skip this questionBank.");
                    Get.to(ScoreScreen());
                  },
                ),
                Expanded(
                  child: _buildList(_questionController.isLoading.value),
                ),
              ],
            ),
          ],
        ),
      ),
      onWillPop: () {
        return Future.value(false); // 不退出

        // if (_lastPressedAt == null ||
        //     DateTime.now().difference(_lastPressedAt).inSeconds > 1) {
        //   print('再按一次 Back 按钮退出');
        //   _lastPressedAt = DateTime.now();
        //   return Future.value(false); // 不退出
        // } else {
        //   print('退出');
        //   _questionController.initValue();
        //   Navigator.of(context).pop(true);
        //   return Future.value(true); // 退出
        // }
      },
    );
  }

  Widget _buildList(bool isLoading) {
    return QuestionCard(
      name: name,
      isLoading: isLoading,
    );
  }
}
