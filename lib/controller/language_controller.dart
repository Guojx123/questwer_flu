import 'dart:ui';
import 'package:get/get.dart';

class LanguageController extends GetxController{

  String _selectValue;

  String get selectValue => this._selectValue;

  /// 更改语言
  void changeLanguage(var language,var country){
    var locale = Locale(language,country);
    Get.updateLocale(locale);
  }

  /// 跟随系统语言
  void followSystemLanguage(){
    var locale = Get.deviceLocale;
    Get.updateLocale(locale);
  }

  /// 设置选择
  void setSelectValue(String value) {
    _selectValue = value;
    update();
  }
}