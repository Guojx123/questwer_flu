
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

/// 软件默认设置
class SettingController extends GetxController{

  RxInt answerQuestionTime = 60.obs;

  String _selectValue;

  String get selectValue => this._selectValue;

  var storage = GetStorage();

  @override
  void onInit() {
    super.onInit();
    _appInit();
  }

  _appInit(){
    // app init
  }

  int get getAnswerTime => storage.read("answerTime") ?? 60;

  setAnswerTime(int second){
    answerQuestionTime.value = second;
    storage.write("answerTime", answerQuestionTime.value);
    update();
  }

  /// 设置选择
  void setSelectValue(String value) {
    _selectValue = value;
    update();
  }
}