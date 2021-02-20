import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:questwer_flu/page/home/home_page.dart';
import 'package:questwer_flu/service/my_text_editing_controller.dart';

class CreateController extends GetxController{

  /// 输入控制
  var inputTitleController = MyTextEditingController();
  var inputDescController = MyTextEditingController();

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
      print("ahhhh");
        _pageController?.nextPage(
            duration: Duration(milliseconds: 50), curve: Curves.ease);
    } else {
      Get.to(HomePage());
    }
  }

}