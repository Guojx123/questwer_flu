import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:questwer_flu/controller/create_controller.dart';
import 'package:questwer_flu/controller/pop_menu_controller.dart';
import 'package:questwer_flu/controller/question_list_controller.dart';
import 'package:questwer_flu/model/question_bank.dart';
import 'package:questwer_flu/page/add/add_page_view.dart';
import 'package:questwer_flu/service/scroll__behavior.dart';
import 'package:questwer_flu/theme/color.dart';
import 'package:questwer_flu/theme/size.dart';
import 'package:questwer_flu/util/shared_preferences.dart';
import 'package:questwer_flu/widget/background_widget.dart';
import 'package:questwer_flu/widget/custom_shape.dart';
import 'package:questwer_flu/widget/question_bank.dart';
import 'package:questwer_flu/widget/smart_refresh_footer.dart';

class QuestionBankListPage extends StatelessWidget {
  final PopMenuController popMenuController = Get.put(PopMenuController());
  final QuestionListController questionListController =
      Get.put(QuestionListController());

  final CreateController createController = Get.put(CreateController());

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
//            bgColor: Color(0xFF00123D),
          ),
          // _buildCustomScrollView(),
          GetBuilder<QuestionListController>(
            init: QuestionListController(),
            builder: (controller) {
              return SmartRefresher(
                physics: BouncingScrollPhysics(),
                controller: questionListController.refreshController,
                enablePullDown: true,
                enablePullUp: false,
                onRefresh: () {
                  questionListController.refreshList();
                  questionListController.refreshController.refreshCompleted();
                  questionListController.refreshController.loadComplete();
                },
                onLoading: () {
                  questionListController.refreshController.loadComplete();
                },
                // header: WaterDropMaterialHeader(
                //   backgroundColor: ColorsTheme.primaryColor,
                //   distance: 30,
                // ),
                footer: RefreshFooter(),
                child: _buildList(controller.isLoading.value),
              );
            }
          ),
          /// 进入引导页
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
                padding: EdgeInsets.symmetric(horizontal:DefaultSize.defaultPadding* 2,vertical:DefaultSize.smallSize * 1.4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.horizontal(right: Radius.circular(DefaultSize.largeSize / 2)),
                  color: rBlueColorEB,
                ),
                child: Padding(
                  padding: EdgeInsets.only(right: DefaultSize.defaultPadding),
                  child: Icon(
                    Icons.arrow_back_sharp,
                    color: kMilkWhiteColor,
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              _createQB();
            },
            child: Container(
              margin: EdgeInsets.symmetric(
                  vertical: DefaultSize.defaultPadding * 1),
              padding: EdgeInsets.symmetric(
                  horizontal: DefaultSize.defaultPadding * 2.2,
                  vertical: DefaultSize.basePadding * 6),
              decoration: BoxDecoration(
                  color: ColorsTheme.white.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(25)),
              child: Icon(
                Icons.add,
                color: ColorsTheme.black.withOpacity(0.7),
                size: DefaultSize.defaultPadding * 3,
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).padding.bottom,
          ),
        ],
      ),
    );
  }

  Widget _buildList(bool isLoading) {
    if (isLoading)
      return Center(
        child: CircularProgressIndicator(),
      );
    else {
      return Padding(
        padding: EdgeInsets.only(top: PersistentStorage.topHeight),
        child: ListView.builder(
            controller: popMenuController.scrollController,
            padding:
                EdgeInsets.symmetric(horizontal: DefaultSize.defaultPadding),
            physics: NeverScrollableScrollPhysics(),
            itemCount: questionListController.questionBankList.length,
            itemBuilder: (context, index) {
              final GlobalKey btnKey = GlobalKey();
              List<QuestionBank> questionBank =
                  questionListController.questionBankList
                      .map((item) => QuestionBank(
                            id: item["id"],
                            name: item["name"],
                            description: item["description"],
                            share: item["share"],
                            owner: item["owner"],
                            shareId: item["shareId"],
                          ))
                      .toList();
              var item = questionBank[index];
              return QuestionBankPage(
                btnKey: btnKey,
                questionBank: item,
              );
            }),
      );
    }
  }


  void _createQB() {
    createController.initAll();
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
