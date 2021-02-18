import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leancloud_storage/leancloud.dart';
import 'package:questwer_flu/http/ApiService.dart';

class QuestionController extends GetxController{

  var isLoading = true.obs;
  var questionList = List<LCObject>().obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  fetchQuestion(String name) async {
    try {
      isLoading(true);
      List<LCObject> question = await ApiService.fetchQuestion(name);
      if(question != null){
        questionList.assignAll(question);
        debugPrint("获取题目数据");
        print(questionList);
        isLoading(false);
      }
    } finally {
      isLoading(false);
    }
    update();
  }


}