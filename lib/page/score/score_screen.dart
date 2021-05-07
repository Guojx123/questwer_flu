import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:questwer_flu/controller/question_controller.dart';
import 'package:questwer_flu/page/home/question_bank_page.dart';
import 'package:questwer_flu/page/lead_page.dart';
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
            bgColor: Color(0xFF00123D),
          ),
          Column(
            children: [
              Spacer(flex: 3),
              Text(
                "score.title".tr,
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
                  Get.offAll(()=>LeadPage());
                },
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(
                      horizontal: DefaultSize.defaultPadding),
                  padding: EdgeInsets.all(DefaultSize.defaultPadding*1.4),
                  decoration: BoxDecoration(
                    gradient: ColorsTheme.rBackBtnGradient,
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  child: Text(
                    "score.btn".tr,
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
