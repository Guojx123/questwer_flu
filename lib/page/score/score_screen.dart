import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:questwer_flu/controller/question_controller.dart';
import 'package:questwer_flu/page/home/lead_pag.dart';
import 'package:questwer_flu/theme/color.dart';
import 'package:questwer_flu/theme/size.dart';
import 'package:questwer_flu/widget/background_widget.dart';

class ScoreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    QuestionController _qnController = Get.put(QuestionController());
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          BackGroundWidget(
            blur: 0.6,
          ),
          Column(
            children: [
              Spacer(flex: 3),
              Text(
                "Your Score",
                style: Theme.of(context)
                    .textTheme
                    .headline3
                    .copyWith(color: ColorsTheme.greyWhite),
              ),
              Spacer(),
              Text(
                "${_qnController.numOfCorrectAns * 10}/${_qnController.questionList.length * 10}",
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    .copyWith(color: ColorsTheme.greyWhite),
              ),
              Spacer(flex: 2),
              GestureDetector(
                onTap: () {
                  Get.offAll(HomePage());
                },
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(
                      horizontal: DefaultSize.defaultPadding * 2),
                  padding: EdgeInsets.all(DefaultSize.defaultPadding),
                  decoration: BoxDecoration(
                    gradient: ColorsTheme.gWelcomeGradient,
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  child: Text(
                    "Back",
                    style: Theme.of(context).textTheme.button.copyWith(
                        color: Colors.white, fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              Spacer(flex: 2),
            ],
          )
        ],
      ),
    );
  }
}
