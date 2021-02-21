import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:leancloud_storage/leancloud.dart';
import 'package:questwer_flu/theme/color.dart';
import 'package:questwer_flu/theme/size.dart';
import 'package:questwer_flu/util/getx_snack_bar.dart';
import 'package:questwer_flu/util/shared_preferences.dart';
import 'package:questwer_flu/widget/background_widget.dart';
import 'package:simple_animations/simple_animations.dart';
import 'home/home_page.dart';

class Welcome extends StatelessWidget {
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackGroundWidget(
            blur: 0.2,
            size: 0.35,
          ),
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.blueGrey.withOpacity(0.5),
          ),
          SafeArea(
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: DefaultSize.defaultPadding),
              child: Column(
                children: [
                  Spacer(),
                  Text(
                    "Let's Play a Q&A.",
                    style: Theme.of(context).textTheme.headline4.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  // Text("Trust me, it must be fun",style: Theme.of(context).textTheme.subtitle1.copyWith(
                  //     color: Colors.white)),
                  Spacer(),
                  Theme(
                    data: new ThemeData(primaryColor: Color(0xff52abbe)),
                    child: TextField(
                      controller: textEditingController,
                      // showCursor: false,
                      cursorColor: ColorsTheme.primaryColor,
                      cursorWidth: 1,
                      keyboardType: TextInputType.text,
                      inputFormatters: [
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
                        labelText: "Nice to meet you.",
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: ColorsTheme.primaryColor),
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
                      padding: EdgeInsets.all(DefaultSize.defaultPadding),
                      decoration: BoxDecoration(
                        gradient: ColorsTheme.gWelcomeGradient,
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      child: Text(
                        "Go",
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
    await PersistentStorage()
        .setStorage("nickname", textEditingController.text.trim());
    Get.to(() => HomePage());
  }
}
