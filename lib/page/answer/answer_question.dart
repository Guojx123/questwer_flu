import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:questwer_flu/controller/question_controller.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                actionFunction: () {
                  print("Tips: Skip this questionBank.");
                },
              ),
              Expanded(child: QuestionCard(name: name,)),
            ],
          ),
        ],
      ),
    );
  }
}
