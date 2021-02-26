import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:questwer_flu/controller/language_controller.dart';
import 'package:questwer_flu/service/scroll__behavior.dart';
import 'package:questwer_flu/widget/title_widget.dart';

import 'select_language_widget.dart';

class SettingPage extends StatelessWidget {
  LanguageController _languageController = Get.put(LanguageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 120,
            ),
            _buildSelectOption(),
            ScrollConfiguration(
              behavior: OverScrollBehavior(),
              child: SelectLanguageWidget(
                'Language',
                ["English", "中文", "跟随系统"],
                ["English", "中文", "setting.follow_system".tr],
                (value) {
                  switch (value) {
                    case "English":
                      LanguageController().changeLanguage("en", "US");
                      break;
                    case "中文":
                      LanguageController().changeLanguage("zh", "CN");
                      break;
                    case "跟随系统":
                      LanguageController().followSystemLanguage();
                      break;
                    case "Follow system":
                      LanguageController().followSystemLanguage();
                      break;
                    default:
                      LanguageController().followSystemLanguage();
                      break;
                  }
                  _languageController.setSelectValue(value);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectOption() {
    return TitleWidget(
      Text(
        "setting.choose_language_desc".tr,
        style: TextStyle(color: Color(0xFF979796), fontSize: 13, height: 1.5),
      ),
      title: "setting.choose_language".tr,
    );
  }
}
