import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:questwer_flu/theme/color.dart';
import 'package:questwer_flu/theme/size.dart';
import 'package:questwer_flu/util/shared_preferences.dart';
import 'package:questwer_flu/widget/common_app_bar.dart';
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
          Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).padding.top,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: DefaultSize.defaultPadding,vertical: DefaultSize.basePadding),
                width: MediaQuery.of(context).size.width,
                child: Text(
                  "hi,${PersistentStorage.get("nickname")}",
                  textAlign:TextAlign.start,
                  style: TextStyle(
                    color: ColorsTheme.white,
                    fontSize: 20
                  ),
                ),
              ),
              Expanded(
                  child: Container()
              ),
            ],
          ),
        ],
      ),
    );
  }
}
