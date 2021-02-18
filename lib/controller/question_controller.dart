import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:leancloud_storage/leancloud.dart';
import 'package:questwer_flu/http/ApiService.dart';
import 'package:questwer_flu/model/question.dart';

class QuestionController extends GetxController{

  // 获取题目数据
  RxBool isLoading = false.obs;
  RxList<LCObject> questionList = List<LCObject>().obs;

  // 页面控制
  PageController _pageController;
  PageController get pageController => this._pageController;

  bool _isAnswered = false;
  bool get isAnswered => this._isAnswered;

  String _correctAns;
  String get correctAns => this._correctAns;

  String _selectedAns;
  String get selectedAns => this._selectedAns;

  RxInt _questionNumber = 1.obs;
  RxInt get questionNumber => this._questionNumber;

  int _numOfCorrectAns = 0;
  int get numOfCorrectAns => this._numOfCorrectAns;

  @override
  void onInit() {
    // TODO: implement onInit
    _pageController = PageController();
    initValue();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    _isAnswered = true;
    _pageController.dispose();
    _numOfCorrectAns = 0;
  }

  initValue(){
    _isAnswered = false;
    _questionNumber = 1.obs;
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


  void checkAns(Question question, String selectedAns) {
    // because once user press any option then it will run
    _isAnswered = true;
    _correctAns = question.correctAnswer;
    _selectedAns = selectedAns;
    if (_correctAns == _selectedAns) _numOfCorrectAns++;

    // It will stop the counter
    // _animationController.stop();
    update();

    // Once user select an ans after 3s it will go to the next qn
    Future.delayed(Duration(seconds: 3), () {
      nextQuestion();
    });
  }

  void nextQuestion() {
    print("number");
    print(_questionNumber.value);
    print(questionList.length);
    if (_questionNumber.value != questionList.length) {
      _isAnswered = false;
      _pageController.nextPage(
          duration: Duration(milliseconds: 250), curve: Curves.ease);

      // Reset the counter
      // _animationController.reset();

      // Then start it again
      // Once timer is finish go to the next qn
      // _animationController.forward().whenComplete(nextQuestion);
    } else {
      // Get package provide us simple way to naviigate another page
      // Get.to(ScoreScreen());
    }
  }

}