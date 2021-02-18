import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:questwer_flu/controller/question_controller.dart';
import 'package:questwer_flu/model/question.dart';

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
    if (widget.isLoading)
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
              correctAnswer: item["correctAnswer"],
              ownedQb: item["ownedQB"],
              creator: item["creator"],
            ))
        .toList();
    Question item = _question[index];
    return ListTile(
      title: Text(
        item.title,
        style: TextStyle(color: Colors.white),
      ),
      subtitle: Text(
        item.subTitle,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
