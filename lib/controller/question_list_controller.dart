import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:leancloud_storage/leancloud.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:questwer_flu/http/ApiService.dart';

class QuestionListController extends GetxController {
  var isLoading = true.obs;
  var _owner = "Q&A";
  var questionBankList = List<LCObject>().obs;

  RefreshController refreshController;

  @override
  void onInit() {
    fetchQuestionBank(_owner);
    refreshController = new RefreshController();
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    refreshController.dispose();
    super.onClose();
  }

  String get owner => this._owner;

  setOwner(String string){
    _owner = string;
    update();
  }

  getCloudOwner() async{
    String owner = await ApiService.getQuestionListOwner();
    _owner = owner;
    update();
    return _owner;
  }

  void refreshList(String owner) async {
    List<LCObject> questionBank = await ApiService.fetchQuestionList(owner);
    questionBankList.clear();
    if (questionBank != null) {
      questionBankList.assignAll(questionBank);
      // showToast("Data refreshed",position: ToastPosition.bottom);
      debugPrint("刷新题库数据");
    }
    update();
  }

  void fetchQuestionBank(String owner) async {
    try {
      isLoading(true);
      List<LCObject> questionBank = await ApiService.fetchQuestionList(owner);
      if (questionBank != null) {
        questionBankList.assignAll(questionBank);
        debugPrint("获取题库数据");
        isLoading(false);
      }
    } finally {
      isLoading(false);
    }
    update();
  }
}
