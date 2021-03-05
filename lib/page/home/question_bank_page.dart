import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:questwer_flu/controller/create_controller.dart';
import 'package:questwer_flu/page/home/question_bank_list.dart';
import 'package:questwer_flu/theme/color.dart';
import 'package:questwer_flu/theme/size.dart';
import 'package:questwer_flu/util/shared_preferences.dart';
import 'package:questwer_flu/widget/background_widget.dart';

class QuestionBankListPage extends StatelessWidget {

  final String owner;

  QuestionBankListPage({Key key, this.owner}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          BackGroundWidget(
            blur: 0.0,
            bgColor: rLightBlueColor,
            circleColor: rCloseGreyColor,
          ),
          // _buildCustomScrollView(),
          QuestionBankList(owner),
          /// 返回引导页
          Positioned(
            left: 0,
            top: PersistentStorage.topHeight + DefaultSize.defaultPadding * 2,
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                Get.back();
                // Get.offAll(LeadPage());
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
                    Icons.store_rounded,
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

}
