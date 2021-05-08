import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:questwer_flu/controller/question_controller.dart';
import 'package:questwer_flu/controller/question_list_controller.dart';
import 'package:questwer_flu/controller/setting_controller.dart';
import 'package:questwer_flu/page/score/score_screen.dart';
import 'package:questwer_flu/theme/color.dart';
import 'package:questwer_flu/theme/size.dart';
import 'package:questwer_flu/widget/background_widget.dart';
import 'package:questwer_flu/widget/common_app_bar.dart';
import 'question_card.dart';

class AnswerQuestion extends StatelessWidget {
  final String name;
  final int categoryId;
  final bool isCategory;

  AnswerQuestion({
    Key key,
    this.name,
    this.categoryId, this.isCategory
  }) : super(key: key);

  QuestionController _questionController = Get.put(QuestionController());
  SettingController _settingController = Get.put(SettingController());
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
              bgColor: Color(0xFF00123D),
            ),
            SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonAppBar(
                    "",
                    canBack: false,
                    actionWidget: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: DefaultSize.defaultPadding * 2,
                          vertical: DefaultSize.basePadding),
                      child: Text(
                        "answerQ.btn".tr,
                        style: TextStyle(
                            color: ColorsTheme.white,
                            fontSize: DefaultSize.fontSize),
                      ),
                    ),
                    actionFunction: () {
                      print("Tips: Skip this questionBank.");
                      Get.to(() => ScoreScreen());
                    },
                  ),
                  // Padding(
                  //     padding: EdgeInsets.symmetric(
                  //         vertical: DefaultSize.defaultPadding),
                  //     child: ProgressBar()),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: DefaultSize.defaultPadding,
                        vertical: DefaultSize.basePadding * 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Obx(
                          () => Text.rich(
                            TextSpan(
                              text: "answerQ.title".tr,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4
                                  .copyWith(color: ColorsTheme.greyWhite),
                              children: [
                                TextSpan(
                                  text:
                                      "${_questionController.questionNumber.value}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline4
                                      .copyWith(color: ColorsTheme.greyWhite),
                                ),
                                TextSpan(
                                  text:
                                      " / ${_questionController.questionList.length}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5
                                      .copyWith(color: kSecondaryColor),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Offstage(
                          offstage: false,
                          child: Container(
                            child: GetBuilder<QuestionController>(
                                init: QuestionController(),
                                builder: (controller) {
                                  double timestamp = controller.animation.value;
                                  return LiquidCustomProgressIndicator(
                                    value: timestamp,
                                    direction: Axis.vertical,
                                    backgroundColor: Colors.grey[300],
                                    valueColor: AlwaysStoppedAnimation(
                                        ColorsTheme.purple),
                                    shapePath: _buildSpeechBubblePath(),
                                    center: Text(
                                      "${_settingController.getAnswerTime - (timestamp * _settingController.getAnswerTime).round()} s",
                                      style: TextStyle(
                                        color: rBlueColor,
                                        height: 0.8,
                                        fontSize: DefaultSize.fontSize,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(thickness: 1.5),
                  Expanded(
                    child: GetBuilder<QuestionListController>(
                        init: QuestionListController(),
                        builder: (controller) {
                          return _buildList(controller.isLoading.value);
                        }),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: DefaultSize.defaultPadding * 2,
                        vertical: DefaultSize.defaultPadding),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.back();
//                            Get.offAll(LeadPage());
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                vertical: DefaultSize.defaultPadding * 2),
                            padding: EdgeInsets.symmetric(
                                horizontal: DefaultSize.defaultPadding * 2.8,
                                vertical: DefaultSize.basePadding * 6),
                            decoration: BoxDecoration(
                                color: ColorsTheme.greyBlue,
                                borderRadius: BorderRadius.circular(25)),
                            child: Icon(
                              Icons.hot_tub_sharp,
                              color: kMilkWhiteColor,
                              size: DefaultSize.defaultPadding * 3,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _questionController.nextQuestion();
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                vertical: DefaultSize.defaultPadding * 2),
                            padding: EdgeInsets.symmetric(
                                horizontal: DefaultSize.defaultPadding * 2.8,
                                vertical: DefaultSize.basePadding * 6),
                            decoration: BoxDecoration(
                                color: ColorsTheme.greyBlue,
                                borderRadius: BorderRadius.circular(25)),
                            child: Icon(
                              Icons.navigate_next,
                              color: kMilkWhiteColor,
                              size: DefaultSize.defaultPadding * 3,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
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
      isCategory: isCategory,
      categoryId: categoryId,
    );
  }

  Path _buildSpeechBubblePath() {
    return Path()
      ..moveTo(26, 0)
      ..quadraticBezierTo(0, 0, 0, 19)
      ..quadraticBezierTo(0, 38, 12, 38)
      ..quadraticBezierTo(12, 48, 2.5, 48)
      ..quadraticBezierTo(18, 48, 20, 38)
      ..quadraticBezierTo(50, 38, 50, 19)
      ..quadraticBezierTo(50, 0, 25, 0)
      ..close();
  }
}
