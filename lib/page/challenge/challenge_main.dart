import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leancloud_storage/leancloud.dart';
import 'package:questwer_flu/controller/category_controller.dart';
import 'package:questwer_flu/theme/color.dart';
import 'package:questwer_flu/theme/size.dart';
import 'package:questwer_flu/util/shared_preferences.dart';
import 'package:questwer_flu/widget/background_widget.dart';

import 'item_card.dart';

class ChallengePage extends StatelessWidget {
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
          challengeList(),

          /// 进入引导页
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

  Widget challengeList() {
    return GetBuilder<CategoryController>(
        init: CategoryController(),
        builder: (controller) {
          if (controller.isLoading.value)
            return Center(
              child: CircularProgressIndicator(),
            );
          else {
            return GridView.builder(
                padding:
                    EdgeInsets.only(top: PersistentStorage.topHeight * 2.8),
                physics: BouncingScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 0,
                  crossAxisSpacing: 0,
                  childAspectRatio: 1.1,
                  crossAxisCount: 2,
                ),
                itemCount: controller.categoryList.length,
                itemBuilder: (BuildContext context, int index) {
                  LCObject lcObject = controller.categoryList[index];
                  return ItemCard(
                    lcObject["imgUrl"],
                    PersistentStorage.screenWidth / 2 -
                        DefaultSize.middleSize * 2,
                    flag: true,
                    icon: Icons.print,
                    title: lcObject["name"] ?? "",
                  );
                });
          }
        });
  }
}
