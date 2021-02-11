import 'package:get/get.dart';
import 'package:leancloud_storage/leancloud.dart';
import 'package:questwer_flu/http/ApiService.dart';
import 'package:questwer_flu/model/question_bank.dart';

class QuestionListController extends GetxController {
  var isLoading = true.obs;
  var questionBankList = List<LCObject>().obs;

  @override
  void onInit() {
    fetchQuestion();
    super.onInit();
  }

  void fetchQuestion() async {
    try {
      isLoading(true);
      List<LCObject> questionBank = await ApiService.fetchQuestion();
      if(questionBank != null){
        questionBankList.assignAll(questionBank);
      }
    } finally {
      isLoading(false);
    }
  }
}
