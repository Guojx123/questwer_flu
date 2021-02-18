import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:questwer_flu/controller/question_controller.dart';
import 'package:questwer_flu/model/question.dart';

class QuestionCard extends StatefulWidget {
  final String name;

  const QuestionCard({Key key, this.name}) : super(key: key);

  @override
  _QuestionCardState createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  QuestionController _questionController = Get.put(QuestionController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _questionController.fetchQuestion(widget.name);
  }

  @override
  Widget build(BuildContext context) {
    return _buildList(_questionController.isLoading.value);
  }

  Widget _buildList(bool isLoading) {
    if (isLoading)
      return Center(
        child: CircularProgressIndicator(),
      );
    else
      return GetBuilder(builder: (context) {
        return ListView.builder(
            itemCount: _questionController.questionList.length,
            itemBuilder: (context, index) {
              List<Question> question =
              _questionController.questionList.map((item) => Question(
                id: item["id"],
                title: item["title"],
                subTitle: item["sub_title"],
                difficulty: item["difficulty"],
                answer: item["answer"],
                correctAnswer: item["correctAnswer"],
                ownedQb: item["ownedQB"],
                creator: item["creator"],
              )).toList();
              var item = question[index];
              return ListTile(
                title: Text(item.title,style: TextStyle(
                  color: Colors.white
                ),),
              );
            });
      });
  }
}
