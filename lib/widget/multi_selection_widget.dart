import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:questwer_flu/controller/create_controller.dart';
import 'package:questwer_flu/theme/color.dart';
import 'package:questwer_flu/theme/size.dart';

class MultiSelectionWidget extends StatelessWidget {
  final List items;
  final List shows;
  final ValueChanged onChange;
  final String title;

  MultiSelectionWidget(this.title, this.items, this.shows, this.onChange);

  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: GetBuilder<CreateController>(
          init: CreateController(),
          builder: (controller) {
            String selectValue = controller.selectValue;
            return Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: items.map((value) {
                  return GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      controller.setSelectValue(value);
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
                              controller.setSelectValue(value);
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
