import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:questwer_flu/controller/language_controller.dart';
import 'package:questwer_flu/service/scroll__behavior.dart';
import 'package:questwer_flu/theme/color.dart';
import 'package:questwer_flu/theme/size.dart';
import 'package:questwer_flu/util/shared_preferences.dart';
import 'package:questwer_flu/widget/background_widget.dart';
import 'package:questwer_flu/widget/title_widget.dart';

import 'select_language_widget.dart';

class SettingPage extends StatelessWidget {
  LanguageController _languageController = Get.put(LanguageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackGroundWidget(
            circleColor: rLightPurpleColor,
            bgColor: rLightBlueColor,
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: PersistentStorage.topHeight + DefaultSize.defaultPadding * 8,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: DefaultSize.defaultPadding),
                  padding: EdgeInsets.only(
                      top: DefaultSize.defaultPadding,
                      bottom: DefaultSize.defaultPadding * 2,
                      // left: DefaultSize.defaultPadding,
                      // right: DefaultSize.defaultPadding,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    color: rBlueColor,
                  ),
                  child: Column(
                    children: [
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
              ],
            ),
          ),
          Positioned(
            left: 0,
            top: PersistentStorage.topHeight + DefaultSize.defaultPadding * 2,
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                Get.back();
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: DefaultSize.defaultPadding * 2,
                    vertical: DefaultSize.smallSize * 1.4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.horizontal(
                      right: Radius.circular(DefaultSize.largeSize / 2)),
                  color: rBlueColorEB,
                ),
                child: Padding(
                  padding: EdgeInsets.only(right: DefaultSize.defaultPadding),
                  child: Icon(
                    Icons.arrow_back_ios_outlined,
                    color: kMilkWhiteColor,
                  ),
                ),
              ),
            ),
          ),
        ],
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
      horizontalMargin: DefaultSize.defaultPadding,
    );
  }
}
