import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:questwer_flu/controller/create_controller.dart';
import 'package:questwer_flu/controller/lead_controller.dart';
import 'package:questwer_flu/controller/question_list_controller.dart';
import 'package:questwer_flu/model/activity.dart';
import 'package:questwer_flu/page/home/question_bank_page.dart';
import 'package:questwer_flu/service/scroll__behavior.dart';
import 'package:questwer_flu/theme/color.dart';
import 'package:questwer_flu/theme/size.dart';
import 'package:questwer_flu/util/shared_preferences.dart';
import 'package:questwer_flu/widget/custom_shape.dart';
import 'package:questwer_flu/widget/gradient_image.dart';
import 'package:questwer_flu/widget/lead_page_layout.dart';

import 'add/add_page_view.dart';
import 'challenge/challenge_main.dart';
import 'home/activity_card.dart';
import 'setting/setting_page.dart';

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
  LeadController _leadController = Get.put(LeadController());

  @override
  void initState() {
    super.initState();
    pageController = PageController(viewportFraction: 0.9);
    _leadController.getActivity();
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
                "${"lead.hi".tr}  ${PersistentStorage.get("nickname")}.",
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: kMilkWhiteColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              actions: [
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: (){
                    Get.to(SettingPage());
                  },
                  child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: DefaultSize.defaultPadding),
                      child: Icon(
                        Icons.settings,
                        color: ColorsTheme.white,
                      )),
                ),
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
                      title: "lead.activity".tr,
                      imgUrl: "assets/icon_activity.png",
                    color: rDeepRedColor,
                  ),
                  _buildActivity(),
                  /// 模式卡片
                  _buildTitle(
                      title: "lead.mode".tr,
                      imgUrl: "assets/icon_model.png",
                    color: rBlueColor,
                  ),
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
              onTap: _createQB,
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
          ],
        ),
      ),
    );
  }

  Widget _buildTitle({String title = "Example Title", String imgUrl,Color color = Colors.black}) {
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
                    color: color,
                  ),
                ),
              ],
            );
          },
        ));
  }

  Widget _buildActivity() {

    int _gradientLength = 720;

    return GetBuilder<LeadController>(
      init: LeadController(),
      builder: (controller) {
        if (controller.isLoading.value)
          return SizedBox(
            height: DefaultSize.largeSize * 3,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        else {
          return SizedBox(
            height: DefaultSize.largeSize * 3,
            child: ScrollConfiguration(
              behavior: OverScrollBehavior(),
              child: ListView.builder(
                  padding: EdgeInsets.symmetric(
                      horizontal: DefaultSize.defaultPadding),
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.activityList.length,
                  itemBuilder: (context, index) {
                    List<Activity> activityList = controller.activityList.map((item) => Activity(
                      id: item["id"],
                      type: item["type"],
                      title: item["title"],
                      subTitle: item["subTitle"],
                      imgUrl: item["imgUrl"],
                    )).toList();
                    var item = activityList[index];
                    return ActivityCard(
                      valueNotifier: notifier,
                      activity: item,
                      gradientLength: 720,
                    );
                  }),
            ),
          );
        }
      }
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
            'lead.hall'.tr,
            'lead.hall_desc'.tr,
            'assets/hall_bg.jpg',
            () {
              Get.to(QuestionBankListPage());
            },
          ),
          PageWidget(
            'lead.mine'.tr,
            'lead.mine_desc'.tr,
            'assets/challenge_bg.png',
                () async {
              String owner= await _questionListController.getCloudOwner();
              Get.to(QuestionBankListPage(owner: owner,));
            },
          ),
          PageWidget(
            'lead.challenge'.tr,
            'lead.challenge_desc'.tr,
            'assets/mine_bg.jpg',
            () {
              Get.to(ChallengePage());
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
      ignoreSafeArea: true,
      enableDrag: false,
      isScrollControlled: true,
      enterBottomSheetDuration: Duration(microseconds: 200),
      exitBottomSheetDuration: Duration(microseconds: 200)
    );
  }
}
