import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:questwer_flu/controller/language_controller.dart';
import 'package:questwer_flu/controller/setting_controller.dart';
import 'package:questwer_flu/service/scroll__behavior.dart';
import 'package:questwer_flu/theme/color.dart';
import 'package:questwer_flu/theme/size.dart';
import 'package:questwer_flu/util/shared_preferences.dart';
import 'package:questwer_flu/widget/background_widget.dart';
import 'package:questwer_flu/widget/title_widget.dart';

import 'select_language_widget.dart';
import 'set_answer_time_widget.dart';

class SettingPage extends StatelessWidget {

  final LanguageController _languageController = Get.put(LanguageController());
  final SettingController _settingController = Get.put(SettingController());

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
                /// 修改语言Widget
                _modifyLanguage(),
                SizedBox(
                  height: DefaultSize.defaultPadding,
                ),
                /// 设置答题时间间隔
                _answerTime(),
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
          Positioned(
            right: DefaultSize.defaultPadding,
            top: PersistentStorage.topHeight + DefaultSize.defaultPadding * 2,
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                showAboutDialog(
                  context: context,
                  applicationIcon: Icon(Icons.verified_user),
                  applicationVersion: '1.0.0',
                  applicationName: 'application.name'.tr,
                  applicationLegalese: 'Gino',
                  children: [

                  ],
                );
              },
              child: Container(
                child: Image.asset(
                  "assets/icon_about.png",
                  width: DefaultSize.smallSize * 6,
                  height: DefaultSize.smallSize * 6,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListTile(String title ,IconData iconData,Function function){
    return ListTile(
      onTap: (){
        _service.sendSms(number);
      },
      leading: Icon(Icons.message),
      title: Text('${Translations.of(context).text('callme')}',style: TextStyle(
        fontWeight: FontWeight.w300,
      ),),
    );
  }

  Widget _modifyLanguage(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: DefaultSize.defaultPadding /2),
      padding: EdgeInsets.only(
        top: DefaultSize.defaultPadding /2,
        bottom: DefaultSize.defaultPadding * 2,
         left: DefaultSize.defaultPadding,
         right: DefaultSize.defaultPadding,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        color: rBlueColor,
      ),
      child: Column(
        children: [
          _buildSelectLanguageOption(),
          ScrollConfiguration(
            behavior: OverScrollBehavior(),
            child: SelectLanguageWidget(
              'Language',
              ["English", "中文", "setting.follow_system".tr],
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
    );
  }

  Widget _answerTime(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: DefaultSize.defaultPadding /2),
      padding: EdgeInsets.only(
        top: DefaultSize.defaultPadding /2,
        bottom: DefaultSize.defaultPadding * 2,
        left: DefaultSize.defaultPadding,
        right: DefaultSize.defaultPadding,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        color: rBlueColor,
      ),
      child: Column(
        children: [
          _buildSetAnswerTimeOption(),
          ScrollConfiguration(
            behavior: OverScrollBehavior(),
            child: SetAnswerTimeWidget(
              'AnswerTime',
              ["30s", "45s", "60s"],
              ["30s", "45s", "60s"],
                  (value) {
                switch (value) {
                  case "30s":
                    _settingController.setAnswerTime(30);
                    break;
                  case "45s":
                    _settingController.setAnswerTime(45);
                    break;
                  case "60s":
                    _settingController.setAnswerTime(60);
                    break;
                  default:
                    _settingController.setAnswerTime(60);
                    break;
                }
                _settingController.setSelectValue(value);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectLanguageOption() {
    return TitleWidget(
      Text(
        "setting.choose_language_desc".tr,
        style: TextStyle(color: Color(0xFF979796), fontSize: 13, height: 1.5),
      ),
      title: "setting.choose_language".tr,
      horizontalMargin: DefaultSize.defaultPadding,
    );
  }

  Widget _buildSetAnswerTimeOption() {
    return TitleWidget(
      Text(
        "setting.answer_time_desc".tr,
        style: TextStyle(color: Color(0xFF979796), fontSize: 13, height: 1.5),
      ),
      title: "setting.answer_time".tr,
      horizontalMargin: DefaultSize.defaultPadding,
    );
  }
}
