import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:leancloud_storage/leancloud.dart';
import 'package:questwer_flu/page/lead_page.dart';
import 'package:questwer_flu/theme/color.dart';
import 'package:questwer_flu/theme/size.dart';
import 'package:questwer_flu/service/getx_snack_bar.dart';
import 'package:questwer_flu/service/shared_preferences.dart';
import 'package:questwer_flu/widget/background_widget.dart';

class Welcome extends StatelessWidget {
  static const String NAME = 'welcome_page';
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackGroundWidget(
            blur: 0.0,
            size: 0.35,
            bgColor: rLightBlueColor,
            circleColor: rCloseGreyColor,
          ),
          SafeArea(
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: DefaultSize.defaultPadding),
              child: Column(
                children: [
                  Spacer(),
                  Text(
                    "welcome.title".tr,
                    style: Theme.of(context).textTheme.headline4.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  // Text("Trust me, it must be fun",style: Theme.of(context).textTheme.subtitle1.copyWith(
                  //     color: Colors.white)),
                  Spacer(),
                  Theme(
                    data: new ThemeData(primaryColor: kMilkWhiteColor),
                    child: TextField(
                      controller: textEditingController,
                      // showCursor: false,
                      cursorColor: rTextColor,
                      cursorWidth: 1,
                      keyboardType: TextInputType.text,
                      inputFormatters: [
                        // 限制用户输入
                        new FilteringTextInputFormatter(
                            new RegExp(
                              '[a-zA-Z]|[\u4e00-\u9fa5]|[0-9]|[`~!@#^&*()=|{}'
                              ',.<>《》/?~！@#￥……&*（）——|{}【】‘；：”“]',
                            ),
                            allow: true),
                      ],
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.transparent,
                        labelText: "welcome.nice_to_meet_you".tr,
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: rTextColor),
                        ),
                        focusColor: ColorsTheme.primaryColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      if (textEditingController.text != null &&
                          textEditingController.text.length > 0) {
                        _loginAnonymously();
                      } else {
                        GetXSnackBar().noEnterNickname();
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(
                          horizontal: DefaultSize.defaultPadding),
                      padding: EdgeInsets.all(DefaultSize.defaultPadding*1.4),
                      decoration: BoxDecoration(
                        gradient: ColorsTheme.rWelcomeBtnGradient,
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      child: Text(
                        "welcome.go".tr,
                        style: Theme.of(context).textTheme.button.copyWith(
                            color: Colors.white, fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  Spacer(flex: 2),
                ],
                crossAxisAlignment: CrossAxisAlignment.start,
              ),
            ),
          ),
        ],
      ),
    );
  }

  _loginAnonymously() async {
    await LCUser.loginAnonymously();
    await PersistentStorage
        .setStorage("nickname", textEditingController.text.trim());
    Get.offAll(()=>LeadPage());
  }
}
