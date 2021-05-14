import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:questwer_flu/controller/question_controller.dart';
import 'package:questwer_flu/model/activity.dart';
import 'package:questwer_flu/page/answer/answer_question.dart';
import 'package:questwer_flu/theme/color.dart';
import 'package:questwer_flu/theme/size.dart';
import 'package:questwer_flu/util/markdown/widget_markdown_page.dart';
import 'package:questwer_flu/service/shared_preferences.dart';
import 'package:questwer_flu/widget/gradient_image.dart';

class ActivityCard extends StatelessWidget {
  final ValueNotifier<double> valueNotifier;
  final Activity activity;
  final num gradientLength;

  const ActivityCard(
      {Key key, this.valueNotifier, this.activity, this.gradientLength})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: valueNotifier,
      builder: (context, value, widget) {
        return GestureDetector(
          onTap: () {
            // TODO：[Gino] 扩展活动类型
            debugPrint('Gino context -> ${activity.context}');
            if (activity.type == 'official') {
              Get.to(() => AnswerQuestion(
                    name: activity.title,
                    isCategory: false,
                  ));
            }else if(activity.type == 'markdown'){
              Get.to(() => MarkdownPage(activity.context,isFilePath: false,title: activity.title,));
            }
          },
          child: Card(
            clipBehavior: Clip.antiAlias,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            margin: EdgeInsets.symmetric(
              vertical: DefaultSize.defaultPadding,
              horizontal: DefaultSize.defaultPadding,
            ),
            color: Color.lerp(
              Color(0xFFC8F0F0),
              Color(0xFFFDE89D),
              valueNotifier.value,
            ),
            child: Container(
              width:
                  PersistentStorage.screenWidth - (DefaultSize.middleSize * 4),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: DefaultSize.defaultPadding * 2,
                      vertical: DefaultSize.smallSize,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical: DefaultSize.defaultPadding),
                          child: Image.asset(
                            "assets/icon_activity_balloon.png",
                            width: DefaultSize.middleSize * 4,
                            height: DefaultSize.middleSize * 4,
                            color: rBlueColor,
                          ),
                        ),
                        SizedBox(
                          height: DefaultSize.middleSize,
                        ),
                        Text(
                          activity.title ?? "Self-love",
                          style: TextStyle(
                            color: rBlueColor,
                            fontSize: DefaultSize.middleFontSize,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "${activity.subTitle} →" ?? "Don't wait, join us!  →",
                          style: TextStyle(
                            color: rPurpleColor,
                            fontSize: DefaultSize.smallFontSize,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // img
                  Expanded(
                    child: GradientImageWidget(
                        gradientLength: gradientLength,
                        imageUrl: activity.imgUrl),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
