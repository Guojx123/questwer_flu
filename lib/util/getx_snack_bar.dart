import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:questwer_flu/theme/color.dart';

/// 通过GetX对SnackBar统一管理
class GetXSnackBar{

  void netError(){
    Get.snackbar("netError.creation_failed".tr, "netError.creation_failed_context".tr,
        colorText: rBlueColor,
        icon: Icon(Icons.messenger,color: rBlueColor,),
        snackPosition: SnackPosition.BOTTOM,
        backgroundGradient: ColorsTheme.gWelcomeGradient);
  }

  void noFillForm(){
    Get.snackbar("netError.no_fill_form".tr, "netError.no_fill_form_context".tr,
        colorText: rBlueColor,
        icon: Icon(Icons.messenger,color: rBlueColor,),
        snackPosition: SnackPosition.BOTTOM,
        backgroundGradient: ColorsTheme.gWelcomeGradient);
  }

  void noTellMeDifficulty(){
    Get.snackbar("netError.no_tell_me_difficulty".tr, "netError.no_tell_me_difficulty_context".tr,
        colorText: rBlueColor,
        icon: Icon(Icons.messenger,color: rBlueColor,),
        snackPosition: SnackPosition.BOTTOM,
        backgroundGradient: ColorsTheme.gWelcomeGradient);
  }

  void noEnterNickname(){
    Get.snackbar("netError.no_enter_nickname".tr, "netError.no_enter_nickname_context".tr,
        colorText: rOrangeColor,
        icon: Icon(Icons.messenger,color: rOrangeColor,),
        snackPosition: SnackPosition.BOTTOM,
        backgroundGradient: ColorsTheme.gWelcomeGradient);
  }

  void createSuccess(){
    Get.snackbar("netError.create_success".tr, "netError.create_success_context".tr,
        colorText: rBlueColor,
        icon: Icon(Icons.messenger,color: rBlueColor,),
        snackPosition: SnackPosition.TOP,
        backgroundGradient: ColorsTheme.gWelcomeGradient);
  }

}