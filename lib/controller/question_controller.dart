import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leancloud_storage/leancloud.dart';
import 'package:questwer_flu/http/ApiService.dart';
import 'package:questwer_flu/model/question.dart';
import 'package:questwer_flu/page/score/score_screen.dart';

class QuestionController extends GetxController
    with SingleGetTickerProviderMixin {
  /// 获取题目数据
  RxBool isLoading = false.obs;
  RxList<LCObject> questionList = List<LCObject>().obs;

  /// 页面控制
  PageController _pageController;

  PageController get pageController => this._pageController;

  /// 动画
  AnimationController _animationController;
  Animation _animation;

  Animation get animation => this._animation;

  /// 基本属性
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
    _animationController =
        AnimationController(duration: Duration(seconds: 60), vsync: this);
    _animation = Tween(begin: 0.0, end: 1.0).animate(_animationController)
      ..addListener(() {
        update();
      });
    // 60秒计时完成后，跳转下一题
    _animationController.forward().whenComplete(nextQuestion);
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    _isAnswered = true;
    _pageController.dispose();
    _numOfCorrectAns = 0;
    _animationController.dispose();
  }

  initValue() {
    _isAnswered = false;
    _questionNumber = 1.obs;
    _numOfCorrectAns = 0;
    _animationController.reset();
    _animationController.forward().whenComplete(nextQuestion);
  }

  pageDispose(){
    _pageController.dispose();
  }

  /// 获取某一题库的题目数据
  fetchQuestion(String name) async {
    try {
      isLoading(true);
      List<LCObject> question = await ApiService.fetchQuestion(name);
      if (question != null) {
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

  /// 检查答案
  void checkAns(Question question, String selectedAns) {
    _isAnswered = true;
    _correctAns = question.correctAnswer;
    _selectedAns = selectedAns;
    if (_correctAns == _selectedAns) _numOfCorrectAns++;

    // 计时停止
    _animationController.stop();
    update();

    // 时间倒数结束，跳转到下一题
    Future.delayed(Duration(seconds: 3), () {
      nextQuestion();
    });
  }

  /// 跳转到下一题
  void nextQuestion() {
    if (_questionNumber.value != questionList.length) {
      _isAnswered = false;
      _pageController.nextPage(
          duration: Duration(milliseconds: 250), curve: Curves.ease);

      // 重置计时器
      _animationController.reset();

      // 重新开始
      // 计时器结束后，转到下一个问题
      _animationController.forward().whenComplete(nextQuestion);
    } else {
      Get.to(ScoreScreen());
    }
  }
}
