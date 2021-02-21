import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leancloud_storage/leancloud.dart';
import 'package:questwer_flu/page/home/home_page.dart';
import 'dart:convert';
import 'package:questwer_flu/service/my_text_editing_controller.dart';

class CreateController extends GetxController {
  /// 输入控制
  /// a.Question Bank
  var inputTitleController = MyTextEditingController();
  var inputDescController = MyTextEditingController();

  /// b.Question
  /// b1.normal question(多项选择题)
  var inputNQTitleController = MyTextEditingController();
  var inputNQDescController = MyTextEditingController();
  var inputCorrectAnswerController = MyTextEditingController();
  var inputOtherFAnswerController = MyTextEditingController();
  var inputOtherSAnswerController = MyTextEditingController();
  var inputOtherTAnswerController = MyTextEditingController();

  /// b2.bool question(判断题)
  var inputBQTitleController = MyTextEditingController();
  var inputBQDescController = MyTextEditingController();
  var inputBCorrectAnswerController = MyTextEditingController();
  var inputBOtherAnswerController = MyTextEditingController();

  /// 页面控制
  PageController _pageController;

  PageController get pageController => this._pageController;

  // 题库难度
  String _difficulty;

  String get difficulty => this._difficulty;

  // 判断题的bool值
  String _selectValue;

  String get selectValue => this._selectValue;

  // 题目所属题库
  String _ownedQB;

  String get ownedQB => this._ownedQB;

  @override
  void onInit() {
    // TODO: implement onInit
    inputTitleController.clear();
    inputDescController.clear();
    _pageController = PageController();
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    inputTitleController.dispose();
    inputDescController.dispose();

    inputNQTitleController.dispose();
    inputNQDescController.dispose();
    inputOtherFAnswerController.dispose();
    inputOtherSAnswerController.dispose();
    inputOtherTAnswerController.dispose();
    inputCorrectAnswerController.dispose();

    inputBQTitleController.dispose();
    inputBQDescController.dispose();
    inputBCorrectAnswerController.dispose();
    inputBOtherAnswerController.dispose();

    _pageController.dispose();
    super.onClose();
  }

  clearNQuestionInput() {
    print("clearNQuestionInput");
    inputNQTitleController.clear();
    inputNQDescController.clear();
    inputOtherFAnswerController.clear();
    inputOtherSAnswerController.clear();
    inputOtherTAnswerController.clear();
    inputCorrectAnswerController.clear();
    update();
  }

  clearBQuestionInput() {
    print("clearBQuestionInput");
    inputBQTitleController.clear();
    inputBQDescController.clear();
    inputBCorrectAnswerController.clear();
    inputBOtherAnswerController.clear();
    update();
  }

  initAll() {
    inputTitleController.clear();
    inputDescController.clear();
    _difficulty = "";
    _selectValue = "true";
    _ownedQB = "";
    _pageController = PageController();
  }

  bool checkInputNull() {
    bool titleNoNull = (inputTitleController.text != null &&
        inputTitleController.text.length > 0);
    bool descNoNull = (inputDescController.text != null &&
        inputDescController.text.length > 0);
    print(inputTitleController.text);
    print(inputDescController.text);
    if (titleNoNull && descNoNull) {
      print("All No Null");
      return false;
    }
    return true;
  }

  setText(String title, TextEditingController textEditingController) {
    textEditingController.text = title;
    update();
  }

  iniStateTextController(TextEditingController textEditingController) {
    textEditingController.addListener(() {
      final text = textEditingController.text.toLowerCase();
      textEditingController.value = textEditingController.value.copyWith(
        text: text,
        selection:
            TextSelection(baseOffset: text.length, extentOffset: text.length),
        composing: TextRange.empty,
      );
    });
  }

  /// 创建题库
  Future<bool> createQuestionBank(String name ,String description) async {
    LCUser currentUser = await LCUser.getCurrent();
    // 构建对象
    LCObject newQB = LCObject("question_bank");
    // 为属性赋值
    _ownedQB = name;
    newQB['name'] = name;
    newQB['description'] = description;
    newQB['owner'] = currentUser.username;
    newQB['share'] = "false";
    newQB['shareId'] = "public";
    // 将对象保存到云端
    try {
      await newQB.save();
      return true;
    } catch (e) {
      print(e);
    }
    return false;
  }

  /// 创建题目
  Future<bool> createQuestion(String title ,String subTitle,String correctAnswer,{String firstOption,String secondOption,String threeOption}) async {

    List answerList = List();
    answerList.add(firstOption);
    answerList.add(secondOption);
    answerList.add(threeOption);
    answerList.add(correctAnswer);

    LCUser currentUser = await LCUser.getCurrent();
    // 构建对象
    LCObject newQ = LCObject("question");
    // 为属性赋值
    newQ['title'] = title;
    newQ['sub_title'] = subTitle;
    newQ['creator'] = currentUser.username;
    newQ['ownedQB'] = _ownedQB;
    newQ['difficulty'] = "1";
    newQ['correct_answer'] = correctAnswer;
    newQ['answer'] = json.encode(answerList);
    // 将对象保存到云端
    try {
      await newQ.save();
      return true;
    } catch (e) {
      print(e);
    }
    return false;
  }

  /// 跳转到下一页
  void nextPage(bool isNoNull) {
    if (isNoNull && _pageController != null) {
      _pageController?.nextPage(
          duration: Duration(milliseconds: 250), curve: Curves.easeOut);
    }
//    else {
//      Get.to(HomePage());
//    }
  }

  void setDifficulty(String string) {
    _difficulty = string;
    update();
  }

  void setSelectValue(String value) {
    _selectValue = value;
    update();
  }
}
