import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:questwer_flu/page/home/home_page.dart';
import 'package:questwer_flu/service/my_text_editing_controller.dart';

class CreateController extends GetxController{

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

  initAll(){
    inputTitleController.clear();
    inputDescController.clear();
    _pageController = PageController();
  }

  bool checkInputNull(){
    bool titleNoNull = (inputTitleController.text != null && inputTitleController.text.length > 0);
    bool descNoNull = (inputDescController.text != null && inputDescController.text.length > 0);
    print(inputTitleController.text);
    print(inputDescController.text);
    if(titleNoNull && descNoNull){
      print("All No Null");
      return false;
    }
    return true;
  }

  setText(String title,TextEditingController textEditingController){
    textEditingController.text = title;
    update();
  }

  iniStateTextController(TextEditingController textEditingController){
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

  /// 跳转到下一页
  void nextPage(bool isNoNull) {
    if (isNoNull && _pageController != null) {
        _pageController?.nextPage(
            duration: Duration(milliseconds: 250), curve: Curves.easeOut);
    } else {
      Get.to(HomePage());
    }
  }

}