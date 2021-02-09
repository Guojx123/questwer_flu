import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:questwer_flu/theme/color.dart';
import 'package:questwer_flu/theme/size.dart';
import 'package:questwer_flu/util/shared_preferences.dart';
import 'package:questwer_flu/widget/scroll__behavior.dart';
import 'package:simple_animations/simple_animations.dart';

class LeadPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Color(0xff000000),
              backgroundBlendMode: BlendMode.srcOver,
            ),
            child: PlasmaRenderer(
              type: PlasmaType.infinity,
              particles: 12,
              color: Color(0x1b0991b5),
              blur: 0.4,
              size: 1,
              speed: 1,
              offset: 0,
              blendMode: BlendMode.screen,
              variation1: 0,
              variation2: 0,
              variation3: 0,
              rotation: 0,
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
                  title: Text(
                    "hi , ${PersistentStorage.get("nickname")}",
                    textAlign: TextAlign.start,
                    style:
                    TextStyle(color: ColorsTheme.white, fontSize: 20),
                  ),
                )
              ];
            },
            body: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: DefaultSize.defaultPadding),
              child: Container(
                width: double.infinity,
                child: ScrollConfiguration(
                  behavior: OverScrollBehavior(),
                  child: ListView.builder(
                      padding: EdgeInsets.zero,
                      physics: BouncingScrollPhysics(),
                      itemCount: 20,
                      itemBuilder: (context, index) {
                        return _buildQuestionBank();
                      }),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildQuestionBank() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: DefaultSize.defaultPadding),
      padding: EdgeInsets.symmetric(
          horizontal: DefaultSize.defaultPadding,
          vertical: DefaultSize.basePadding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        gradient: ColorsTheme.kCardGradient,
      ),
      child: Row(
        children: [
          Image.asset(
            "assets/icon_questions.png",
            width: DefaultSize.defaultPadding * 5,
            height: DefaultSize.defaultPadding * 5,
          ),
          Expanded(
            child: Container(
              padding:
                  EdgeInsets.symmetric(horizontal: DefaultSize.basePadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "New Question List",
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.visible,
                    style: TextStyle(
                        fontSize: 20, height: 1.4, color: ColorsTheme.white),
                  ),
                  Text(
                    "Test your love for music Test your love for music Test your love for music Test your love for music.",
                    textAlign: TextAlign.start,
                    maxLines: 3,
                    overflow: TextOverflow.visible,
                    style: TextStyle(fontSize: 16, color: ColorsTheme.white),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
