import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:questwer_flu/controller/pop_menu_controller.dart';
import 'package:questwer_flu/service/key_value.dart';
import 'package:questwer_flu/theme/color.dart';
import 'package:questwer_flu/theme/size.dart';
import 'package:questwer_flu/util/shared_preferences.dart';
import 'package:questwer_flu/widget/question_bank.dart';
import 'package:questwer_flu/widget/scroll__behavior.dart';
import 'package:simple_animations/simple_animations.dart';

class LeadPage extends StatelessWidget {
  PopMenuController popMenuController = PopMenuController();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Color(0xff00123d),
                backgroundBlendMode: BlendMode.srcOver,
              ),
              child: PlasmaRenderer(
                type: PlasmaType.infinity,
                particles: 12,
                color: Color(0xAc448dc7),
                blur: 0,
                size: 0.6,
                speed: 1,
                offset: 0,
                blendMode: BlendMode.screen,
                variation1: 0,
                variation2: 0,
                variation3: 0,
                rotation: 1,
              ),
            ),
            NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    backgroundColor: Colors.transparent,
                    automaticallyImplyLeading: false,
                    toolbarHeight: DefaultSize.defaultPadding * 3,
                    brightness: Brightness.dark,
                    elevation: 0,
                    title: Text(
                      "Hi !  ${PersistentStorage.get("nickname")}.",
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: ColorsTheme.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ];
              },
              body: Container(
                width: double.infinity,
                child: ScrollConfiguration(
                  behavior: OverScrollBehavior(),
                  child: ListView.builder(
                      padding: EdgeInsets.symmetric(
                          horizontal: DefaultSize.defaultPadding),
                      physics: BouncingScrollPhysics(),
                      itemCount: 20,
                      itemBuilder: (context, index) {
                        final GlobalKey btnKey = GlobalKey();
                        return QuestionBank(
                          btnKey: btnKey,
                        );
                      }),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                print("sssssss");
              },
              child: Container(
                margin:
                EdgeInsets.symmetric(vertical: DefaultSize.defaultPadding * 2),
                padding: EdgeInsets.symmetric(
                    horizontal: DefaultSize.defaultPadding * 2,
                    vertical: DefaultSize.basePadding * 5),
                decoration: BoxDecoration(
                    color: ColorsTheme.black.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(25)),
                child: Icon(
                  Icons.add,
                  color: ColorsTheme.white.withOpacity(0.8),
                  size: DefaultSize.defaultPadding * 3,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
