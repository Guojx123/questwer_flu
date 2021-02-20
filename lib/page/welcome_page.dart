import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:leancloud_storage/leancloud.dart';
import 'package:questwer_flu/theme/color.dart';
import 'package:questwer_flu/theme/size.dart';
import 'package:questwer_flu/util/shared_preferences.dart';
import 'package:simple_animations/simple_animations.dart';
import 'home/lead_pag.dart';

class Welcome extends StatelessWidget {
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                tileMode: TileMode.mirror,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xff0fbcdf),
                  Color(0xff03203e),
                ],
                stops: [
                  0,
                  1,
                ],
              ),
              backgroundBlendMode: BlendMode.srcOver,
            ),
            child: PlasmaRenderer(
              type: PlasmaType.infinity,
              particles: 14,
              color: Color(0x44ffffff),
              blur: 0.16,
              size: 0.21,
              speed: 0.91,
              offset: 1.3,
              blendMode: BlendMode.screen,
              variation1: 0.31,
              variation2: 0.3,
              variation3: 0.13,
              rotation: -0.79,
            ),
          ),
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.blueGrey.withOpacity(0.5),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: DefaultSize.defaultPadding),
              child: Column(
                children: [
                  Spacer(),
                  //2/6
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
                              '[a-zA-Z]|[\u4e00-\u9fa5]|[0-9]|[`~!@#^&*()=|{}'',.<>《》/?~！@#￥……&*（）——|{}【】‘；：”“]',
                            ),
                            allow: true),
                      ],
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.transparent,
                        labelText: "Nice to meet you.",
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: ColorsTheme.primaryColor),
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
                        Get.snackbar("Tips", "Please enter a nickname",
                            colorText: ColorsTheme.white,
                            icon: Icon(Icons.messenger),
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundGradient: ColorsTheme.gWelcomeGradient);
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
                  // it will take 2/6 spaces
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
    await PersistentStorage().setStorage("nickname", textEditingController.text.trim());
    Get.to(HomePage());
  }
}
