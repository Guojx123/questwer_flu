import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:leancloud_storage/leancloud.dart';
import 'package:popup_menu/popup_menu.dart';
import 'package:questwer_flu/controller/pop_menu_controller.dart';
import 'package:questwer_flu/controller/question_controller.dart';
import 'package:questwer_flu/model/question_bank.dart';
import 'package:questwer_flu/page/answer/answer_question.dart';
import 'package:questwer_flu/theme/color.dart';
import 'package:questwer_flu/theme/size.dart';
import 'package:get/get.dart';


class QuestionBankItem extends StatefulWidget {
  final GlobalKey btnKey;
  final QuestionBank questionBank;

  const QuestionBankItem({Key key, this.btnKey, this.questionBank})
      : super(key: key);

  @override
  _QuestionBankItemState createState() => _QuestionBankItemState();
}

class _QuestionBankItemState extends State<QuestionBankItem> {
  PopMenuController popMenuController = Get.put(PopMenuController());
  QuestionController questionController = Get.put(QuestionController());

  QuestionBank get _questionBank => widget.questionBank;

  @override
  Widget build(BuildContext context) {
    PopupMenu.context = context;

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        Get.to(AnswerQuestion(
          name: _questionBank.name,
          isCategory: false,
        ));
        questionController.onStart();
        questionController.initValue();
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: DefaultSize.defaultPadding),
        padding: EdgeInsets.symmetric(
            horizontal: DefaultSize.defaultPadding,
            vertical: DefaultSize.defaultPadding),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            gradient: ColorsTheme.aCardGradient,
            boxShadow: [
              BoxShadow(
                  color: Colors.black12,
                  offset: Offset(2.0, 4.0), //阴影xy轴偏移量
                  blurRadius: 20.0, //阴影模糊程度
                  spreadRadius: 1.0 //阴影扩散程度
                  ),
            ]),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.center,
              child: Image.asset(
                "assets/icon_questions.png",
                width: DefaultSize.defaultPadding * 5,
                height: DefaultSize.defaultPadding * 5,
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: DefaultSize.defaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${_questionBank.name ?? "New Question List"}",
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.visible,
                      style: TextStyle(
                          fontSize: 20, height: 1.4, color: ColorsTheme.white),
                    ),
                    Text(
                      "${_questionBank.description ?? "Test your love music."}",
                      textAlign: TextAlign.start,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 16, color: ColorsTheme.grey, height: 1.4),
                    ),
                  ],
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    key: widget.btnKey,
                    onTap: () {
                      popMenuController.menu.show(widgetKey: widget.btnKey);
                    },
                    child: Icon(
                      Icons.more_horiz,
                      size: DefaultSize.defaultPadding * 2,
                      color: ColorsTheme.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: DefaultSize.defaultPadding * 4,
                ),
                Icon(
                  Icons.create_outlined,
                  size: DefaultSize.defaultPadding * 2,
                  color: ColorsTheme.white,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
