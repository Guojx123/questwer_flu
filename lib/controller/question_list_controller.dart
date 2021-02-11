import 'package:get/get.dart';
import 'package:leancloud_storage/leancloud.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:questwer_flu/http/ApiService.dart';

class QuestionListController extends GetxController {
  var isLoading = true.obs;
  var questionBankList = List<LCObject>().obs;

  RefreshController refreshController;

  @override
  void onInit() {
    fetchQuestion();
    refreshController = new RefreshController();
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    refreshController.dispose();
    super.onClose();
  }

  void fetchQuestion() async {
    try {
      isLoading(true);
      List<LCObject> questionBank = await ApiService.fetchQuestion();
      if(questionBank != null){
        questionBankList.assignAll(questionBank);
        isLoading(false);
      }
    } finally {
      isLoading(false);
    }
  }
}
