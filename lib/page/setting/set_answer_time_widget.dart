import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:questwer_flu/controller/language_controller.dart';
import 'package:questwer_flu/controller/setting_controller.dart';
import 'package:questwer_flu/theme/color.dart';
import 'package:questwer_flu/theme/size.dart';

class SetAnswerTimeWidget extends StatelessWidget {
  final List items;
  final List shows;
  final ValueChanged onChange;
  final String title;

  SetAnswerTimeWidget(this.title, this.items, this.shows, this.onChange);

  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: GetBuilder<SettingController>(
          init: SettingController(),
          builder: (controller) {
            String selectValue = controller.selectValue;
            return Container(
              width: Get.mediaQuery.size.width - DefaultSize.defaultPadding * 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: items.map((value) {
                  return GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      onChange(value);
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: DefaultSize.defaultPadding),
                      padding: EdgeInsets.only(
                          right: DefaultSize.defaultPadding * 2),
                      decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.circular(DefaultSize.smallSize),
                        color: rTextWhiteColor,
                      ),
                      child: Row(
                        children: <Widget>[
                          Radio(
                            activeColor: rBlueColor,
                            hoverColor: rLightPurpleColor,
                            value: value,
                            groupValue: selectValue,
                            onChanged: (value) {
                              onChange(value);
                            },
                          ),
                          Text('$value'),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            );
          }),
    );
  }
}
