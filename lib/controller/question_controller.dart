import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leancloud_storage/leancloud.dart';
import 'package:questwer_flu/http/ApiService.dart';

class QuestionController extends GetxController{

  // 获取题目数据
  RxBool isLoading = false.obs;
  RxList<LCObject> questionList = List<LCObject>().obs;

  // 页面控制
  PageController _pageController;
  PageController get pageController => this._pageController;

  bool _isAnswered = false;
  bool get isAnswered => this._isAnswered;

  int _correctAns;
  int get correctAns => this._correctAns;

  int _selectedAns;
  int get selectedAns => this._selectedAns;

  RxInt _questionNumber = 1.obs;
  RxInt get questionNumber => this._questionNumber;

  int _numOfCorrectAns = 0;
  int get numOfCorrectAns => this._numOfCorrectAns;

  @override
  void onInit() {
    // TODO: implement onInit
    _pageController = PageController();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    _pageController.dispose();
  }

  /// 获取某一题库的题目数据
  fetchQuestion(String name) async {
    try {
      isLoading(true);
      List<LCObject> question = await ApiService.fetchQuestion(name);
      if(question != null){
        questionList.assignAll(question);
        isLoading(false);
        debugPrint("获取题目数据");
        print(questionList);
      }
    } finally {
      print("执行结束");
      isLoading(false);
    }
    update();
  }

  /// 更改题号
  void updateTheQnNum(int index) {
    _questionNumber.value = index + 1;
  }

}