import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:questwer_flu/controller/create_controller.dart';
import 'package:questwer_flu/controller/question_list_controller.dart';
import 'package:questwer_flu/page/home/question_bank_page.dart';
import 'package:questwer_flu/service/scroll__behavior.dart';
import 'package:questwer_flu/theme/color.dart';
import 'package:questwer_flu/theme/size.dart';
import 'package:questwer_flu/util/shared_preferences.dart';
import 'package:questwer_flu/widget/custom_shape.dart';
import 'package:questwer_flu/widget/lead_page_layout.dart';

import 'add/add_page_view.dart';

class LeadPage extends StatefulWidget {
  final String title;

  LeadPage({Key key, this.title}) : super(key: key);

  @override
  _LeadPageState createState() => _LeadPageState();
}

class _LeadPageState extends State<LeadPage> {
  PageController pageController;
  ValueNotifier<double> notifier = ValueNotifier<double>(0);
  QuestionListController _questionListController = Get.put(QuestionListController());
  CreateController _createController = Get.put(CreateController());

  @override
  void initState() {
    super.initState();
    pageController = PageController(viewportFraction: 0.9);
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: true,
      child: Scaffold(
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            /// 页面底色
            ValueListenableBuilder(
              valueListenable: notifier,
              builder: (context, value, widget) {
                return Container(
                  color: Color.lerp(
                    rLeadTealColor,
                    rLeadSunColor,
                    notifier.value,
                  ),
                );
              },
            ),
            /// 自定义AppBar
            AppBar(
              backgroundColor: Colors.transparent,
              automaticallyImplyLeading: false,
              // toolbarHeight: DefaultSize.defaultPadding * 4,
              brightness: Brightness.dark,
              elevation: 0,
              title: Text(
                "Hi !  ${PersistentStorage.get("nickname")}.",
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: kMilkWhiteColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              actions: [
                Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: DefaultSize.defaultPadding),
                    child: Icon(
                      Icons.settings,
                      color: ColorsTheme.white,
                    )),
              ],
            ),
            /// 页面主体
            Container(
              padding: EdgeInsets.symmetric(vertical: DefaultSize.smallSize),
              decoration: BoxDecoration(
                color: kMilkWhiteColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              height: MediaQuery.of(context).size.height * 0.89,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: DefaultSize.smallSize,
                  ),
                  /// 官方活动
                  _buildTitle(
                      title: "Popular activities",
                      imgUrl: "assets/icon_activity.png"),
                  _buildActivity(),
                  /// 模式卡片
                  _buildTitle(
                      title: "Choose answer mode",
                      imgUrl: "assets/icon_model.png"),
                  _buildModel(),
                  SizedBox(
                    height: DefaultSize.smallSize,
                  ),
                  _buildLinearProgress(),
                ],
              ),
            ),
            /// 新建题目
            GestureDetector(
              onTap: () {
                _createQB();
              },
              child: Container(
                margin: EdgeInsets.symmetric(
                    vertical: DefaultSize.defaultPadding * 2),
                padding: EdgeInsets.symmetric(
                    horizontal: DefaultSize.defaultPadding * 2.2,
                    vertical: DefaultSize.basePadding * 6),
                decoration: BoxDecoration(
                    color: ColorsTheme.greyBlue,
                    borderRadius: BorderRadius.circular(25)),
                child: Icon(
                  Icons.add,
                  color: kMilkWhiteColor,
                  size: DefaultSize.defaultPadding * 3,
                ),
              ),
            ),
//            SizedBox(
//              height: MediaQuery.of(context).padding.bottom + DefaultSize.basePadding,
//            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle({String title = "Example Title", String imgUrl}) {
    return Padding(
        padding: EdgeInsets.symmetric(
            horizontal: DefaultSize.defaultPadding * 2,
            vertical: DefaultSize.smallSize),
        child: ValueListenableBuilder(
          valueListenable: notifier,
          builder: (context, value, widget) {
            return Row(
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: rBlueColor,
                    fontSize: DefaultSize.middleFontSize * 1.2,
                    height: smallSize * 3,
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: DefaultSize.middleSize),
                  child: Image.asset(
                    imgUrl,
                    height: DefaultSize.middleSize * 2.2,
                    width: DefaultSize.middleSize * 2.2,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            );
          },
        ));
  }

  Widget _buildActivity() {
    return SizedBox(
      height: DefaultSize.largeSize * 3,
      child: ScrollConfiguration(
        behavior: OverScrollBehavior(),
        child: ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: DefaultSize.defaultPadding),
            scrollDirection: Axis.horizontal,
            itemCount: 4,
            itemBuilder: (context, index) {
              return ValueListenableBuilder(
                valueListenable: notifier,
                builder: (context, value, widget) {
                  return Card(
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    margin: EdgeInsets.symmetric(
                      vertical: DefaultSize.defaultPadding,
                      horizontal: DefaultSize.defaultPadding,
                    ),
                    color: Color.lerp(
                      Color(0xFFC8F0F0),
                      Color(0xFFFDE89D),
                      notifier.value,
                    ),
                    child: Container(
                      width: PersistentStorage.screenWidth -
                          (DefaultSize.middleSize * 4),
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
                                  "Self-love",
                                  style: TextStyle(
                                    color: rBlueColor,
                                    fontSize: DefaultSize.middleFontSize,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "Don't wait, join us!  →",
                                  style: TextStyle(
                                    color: rPurpleColor,
                                    fontSize: DefaultSize.smallFontSize,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // icon
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
      ),
    );
  }

  Widget _buildModel() {
    return Expanded(
      child: PageView(
        /// 是否捕捉页面悬停
        pageSnapping: true,
        physics: new BouncingScrollPhysics(),
        /// 解决：反向滑动抛出异常，页面丢失
        allowImplicitScrolling: true,
        reverse: false,
        controller: pageController
          ..addListener(() {
            notifier.value =
                pageController.offset / pageController.position.maxScrollExtent;
          }),
        children: <Widget>[
          PageWidget(
            'Hall',
            'To tell you, here you can view the question bank shared by all users.',
            'assets/hall_bg.jpg',
            () {
              Get.to(QuestionBankListPage());
            },
          ),
          PageWidget(
            'Mine',
            'Congratulations, here is everything about you.',
            'assets/challenge_bg.png',
                () async {
              String owner= await _questionListController.getCloudOwner();
              Get.to(QuestionBankListPage(owner: owner,));
            },
          ),
          PageWidget(
            'Challenge',
            'Are you ready? Here are various topics collected on the Internet.',
            'assets/mine_bg.jpg',
            () {
              // Navigator.push(context, MaterialPageRoute(builder: (context) => SkillMainPage()));
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLinearProgress() {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: DefaultSize.smallSize,
        horizontal: DefaultSize.middleSize * 4,
      ),
      child: ValueListenableBuilder(
        valueListenable: notifier,
        builder: (context, value, widget) {
          return LinearProgressIndicator(
            value: notifier.value,
            minHeight: DefaultSize.smallSize,
            valueColor: AlwaysStoppedAnimation(
              Color.lerp(
                rLeadTealColor,
                rLeadSunColor,
                notifier.value,
              ),
            ),
            backgroundColor: rBlueColor2C,
          );
        },
      ),
    );
  }

  void _createQB() {
    _createController.initAll();
    Get.bottomSheet(
      ScrollConfiguration(
        behavior: OverScrollBehavior(),
        child: AddPageView(),
      ),
      shape: CustomRoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
            top: Radius.circular(DefaultSize.middleSize * 2)),
        borderWidth: 10.0,
        bgColor: rMiddlePurpleColor,
      ),
      elevation: 0,
      backgroundColor: rMiddlePurpleColor,
      ignoreSafeArea: false,
      enableDrag: true,
      isScrollControlled: true,
    );
  }
}
