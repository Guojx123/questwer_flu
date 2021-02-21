import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:questwer_flu/controller/question_controller.dart';
import 'package:questwer_flu/model/question.dart';
import 'package:questwer_flu/theme/color.dart';
import 'package:questwer_flu/theme/size.dart';

import 'option.dart';

class QuestionCard extends StatefulWidget {
  final String name;
  final bool isLoading;

  const QuestionCard({Key key, this.name, this.isLoading}) : super(key: key);

  @override
  _QuestionCardState createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  QuestionController _questionController = Get.put(QuestionController());
  List<Question> _question;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _question = List();
    _questionController.fetchQuestion(widget.name);
  }

  @override
  Widget build(BuildContext context) {
    if (_questionController.isLoading.value &&
        _questionController.questionList.length > 0)
      return Center(
        child: CircularProgressIndicator(),
      );
    else
      return Obx(
        () => PageView.builder(
            physics: NeverScrollableScrollPhysics(),
            controller: _questionController.pageController,
            onPageChanged: _questionController.updateTheQnNum,
            itemCount: _questionController.questionList.length,
            itemBuilder: (context, index) => _questionItem(index)),
      );
  }

  Widget _questionItem(int index) {
    _question = _questionController.questionList
        .map((item) => Question(
              id: item["id"],
              title: item["title"],
              subTitle: item["sub_title"],
              difficulty: item["difficulty"],
              answer: item["answer"],
              correctAnswer: item["correct_answer"],
              ownedQb: item["ownedQB"],
              creator: item["creator"],
            ))
        .toList();

    Question item = _question[index];
    /// 解析字符串
    List answerList = json.decode(item.answer);
//    answerList.add(item.correctAnswer);
    answerList.shuffle();
    /// 直接使用数组，不需要解析
//    List answerList = item.answer;
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: DefaultSize.defaultPadding,
          vertical: DefaultSize.defaultPadding),
      padding: EdgeInsets.all(DefaultSize.defaultPadding),
      decoration: BoxDecoration(
        color: ColorsTheme.white.withOpacity(0.94),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        children: [
          ListTile(
            title: Text(
              item.title,
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  .copyWith(color: ColorsTheme.black),
            ),
            subtitle: Text(
              item.subTitle,
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  .copyWith(color: ColorsTheme.black),
            ),
          ),
          SizedBox(height: DefaultSize.defaultPadding / 2),
          ...List.generate(
            answerList.length,
            (index) => Option(
              index: index,
              text: answerList[index],
              press: () =>
                  _questionController.checkAns(item, answerList[index]),
            ),
          ),
        ],
      ),
    );
  }
}
