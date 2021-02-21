import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leancloud_storage/leancloud.dart';
import 'package:questwer_flu/page/home/home_page.dart';
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

  String _difficulty;

  String get difficulty => this._difficulty;

  String _selectValue;

  String get selectValue => this._selectValue;

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

  Future<bool> createQuestionBank(String name ,String description) async {
    LCUser currentUser = await LCUser.getCurrent();
    // 构建对象
    LCObject newQuestion = LCObject("question_bank");
    // 为属性赋值
    newQuestion['name'] = name;
    newQuestion['description'] = description;
    newQuestion['owner'] = currentUser.username;
    newQuestion['share'] = "false";
    newQuestion['shareId'] = "public";
    // 将对象保存到云端
    try {
      await newQuestion.save();
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
