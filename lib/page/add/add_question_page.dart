import 'package:flutter/material.dart';
import 'package:questwer_flu/theme/size.dart';
import 'package:questwer_flu/widget/title_widget.dart';

import 'custom_tab.dart';
import 'question_textfield.dart';

class CreateQuestion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomTab(
      leftWidget: _buildCreateQuestion(),
      rightWidget: _buildCreateQuestion(),
    );
  }

  Widget _buildCreateQuestion(){
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: DefaultSize.defaultPadding * 2,
          vertical: DefaultSize.defaultPadding),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _buildCreateNQTitle(),
            NQuestionTextFieldWidget(),
            _buildCreateNQOption(),
            NQuestionOptionTextFieldWidget(),
            _buildCreateNQCorrectAnswer(),
            NQuestionCorrectAnswerTextFieldWidget(),
          ],
        ),
      ),
    );
  }

  Widget _buildCreateNQTitle(){
    return TitleWidget(
      Text(
        "Add a description to your new question.",
        style: TextStyle(color: Color(0xFF979796), fontSize: 13, height: 1.5),
      ),
      title: "Create Question Title",
    );
  }

  Widget _buildCreateNQOption(){
    return TitleWidget(
      Text(
        "Add options to your new question.",
        style: TextStyle(color: Color(0xFF979796), fontSize: 13, height: 1.5),
      ),
      title: "Question Option (At least three)",
    );
  }

  Widget _buildCreateNQCorrectAnswer(){
    return TitleWidget(
      Text(
        "Add the correct answer to your new question.",
        style: TextStyle(color: Color(0xFF979796), fontSize: 13, height: 1.5),
      ),
      title: "Question Correct Answer (Only one)",
    );
  }
}
