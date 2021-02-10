import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:popup_menu/popup_menu.dart';
import 'package:questwer_flu/controller/pop_menu_controller.dart';
import 'package:questwer_flu/theme/color.dart';
import 'package:questwer_flu/theme/size.dart';
import 'package:get/get.dart';

class QuestionBank extends StatefulWidget {

  final GlobalKey btnKey;

  const QuestionBank({Key key, this.btnKey}) : super(key: key);

  @override
  _QuestionBankState createState() => _QuestionBankState();
}

class _QuestionBankState extends State<QuestionBank> {

  PopMenuController popMenuController = Get.put(PopMenuController());

  @override
  Widget build(BuildContext context) {
    PopupMenu.context = context;

    return Container(
      margin: EdgeInsets.symmetric(vertical: DefaultSize.defaultPadding),
      padding: EdgeInsets.symmetric(
          horizontal: DefaultSize.defaultPadding,
          vertical: DefaultSize.defaultPadding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        gradient: ColorsTheme.kCardGradient,
      ),
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
              padding:
              EdgeInsets.symmetric(horizontal: DefaultSize.defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "New Question List",
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.visible,
                    style: TextStyle(
                        fontSize: 20, height: 1.4, color: ColorsTheme.white),
                  ),
                  Text(
                    "Test your love music. ",
                    textAlign: TextAlign.start,
                    maxLines: 3,
                    overflow: TextOverflow.visible,
                    style: TextStyle(
                        fontSize: 16,
                        color: ColorsTheme.white,
                        height: 1.4
                    ),
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
                  onTap: (){
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
    );
  }
}