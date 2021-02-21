import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:questwer_flu/theme/color.dart';

/// 通过GetX对SnackBar统一管理
class GetXSnackBar{

  void netError(){
    Get.snackbar("Creation failed", "We encountered an unknown error.",
        colorText: rBlueColor,
        icon: Icon(Icons.messenger),
        snackPosition: SnackPosition.BOTTOM,
        backgroundGradient: ColorsTheme.gWelcomeGradient);
  }

  void noFillForm(){
    Get.snackbar("Yep！", "I found that you haven't filled out the form.",
        colorText: rBlueColor,
        icon: Icon(Icons.messenger),
        snackPosition: SnackPosition.BOTTOM,
        backgroundGradient: ColorsTheme.gWelcomeGradient);
  }

  void noTellMeDifficulty(){
    Get.snackbar("Yep！", "Tell me how difficult the question is.",
        colorText: rBlueColor,
        icon: Icon(Icons.messenger),
        snackPosition: SnackPosition.BOTTOM,
        backgroundGradient: ColorsTheme.gWelcomeGradient);
  }

  void noEnterNickname(){
    Get.snackbar("Tips:", "Please enter a nickname.",
        colorText: ColorsTheme.white,
        icon: Icon(Icons.messenger),
        snackPosition: SnackPosition.BOTTOM,
        backgroundGradient: ColorsTheme.gWelcomeGradient);
  }

  void createSuccess(){
    Get.snackbar("Good news", "Created successfully.",
        colorText: ColorsTheme.white,
        icon: Icon(Icons.messenger),
        snackPosition: SnackPosition.BOTTOM,
        backgroundGradient: ColorsTheme.gWelcomeGradient);
  }

}