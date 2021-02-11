import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:questwer_flu/controller/question_controller.dart';
import 'package:questwer_flu/theme/size.dart';
import 'package:questwer_flu/widget/background_widget.dart';
import 'package:questwer_flu/widget/common_app_bar.dart';

class AnswerQuestion extends StatelessWidget {
  final num id;

  AnswerQuestion({
    Key key,
    this.id,
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
          CommonAppBar(
            "", canBack: false,
            actionWidget: FlatButton(
              onPressed: (){
                print("Skip");
              },
              child: Text("Skip",style: TextStyle(
                  color: Colors.white
              ),),
            ),
            actionFunction: () {
              print("Tips: Skip");
            },
          ),
          // GetBuilder(
          //   initState: _questionController.fetchQuestion(id),
          //     builder: (context){
          //       return ListTile(
          //         title: Text("${_questionController.questionList[0]['name']}"),
          //       );
          //     }
          // ),
        ],
      ),
    );
  }
}
