import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:questwer_flu/controller/pop_menu_controller.dart';
import 'package:questwer_flu/controller/question_list_controller.dart';
import 'package:questwer_flu/service/key_value.dart';
import 'package:questwer_flu/theme/color.dart';
import 'package:questwer_flu/theme/size.dart';
import 'package:questwer_flu/util/shared_preferences.dart';
import 'package:questwer_flu/widget/background_widget.dart';
import 'package:questwer_flu/widget/question_bank.dart';
import 'package:questwer_flu/widget/scroll__behavior.dart';
import 'package:questwer_flu/widget/smart_refresh_footer.dart';
import 'package:simple_animations/simple_animations.dart';

class LeadPage extends StatelessWidget {

  PopMenuController popMenuController = Get.put(PopMenuController());
  QuestionListController questionListController =
  Get.put(QuestionListController());

  @override
  Widget build(BuildContext context) {

    return Material(
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          BackGroundWidget(blur: 0.6,),
          NestedScrollView(
            key: UniqueKey(),
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  backgroundColor: Colors.transparent,
                  automaticallyImplyLeading: false,
                  toolbarHeight: DefaultSize.defaultPadding * 3,
                  brightness: Brightness.dark,
                  elevation: 0,
                  title: Text(
                    "Hi !  ${PersistentStorage.get("nickname")}.",
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: ColorsTheme.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  actions: [
                    Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: DefaultSize.defaultPadding),
                        child: Icon(Icons.settings,color: ColorsTheme.white,))
                  ],
                ),
              ];
            },
            body: Container(
              width: double.infinity,
              child: ScrollConfiguration(
                behavior: OverScrollBehavior(),
                child: GetBuilder(
                  init: QuestionListController(),
                  builder: (context) {
                    return SmartRefresher(
                      physics: BouncingScrollPhysics(),
                      controller: questionListController.refreshController,
                      enablePullDown: true,
                      enablePullUp: false,
                      onRefresh: () {
                        questionListController.refreshList();
                        questionListController.refreshController
                            .refreshCompleted();
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
                      child: _buildList(questionListController.isLoading.value),
                    );
                  },
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              // print("sssssss");
              showToast("content");
            },
            child: Container(
              margin: EdgeInsets.symmetric(
                  vertical: DefaultSize.defaultPadding * 1),
              padding: EdgeInsets.symmetric(
                  horizontal: DefaultSize.defaultPadding * 2.2,
                  vertical: DefaultSize.basePadding * 6),
              decoration: BoxDecoration(
                  color: ColorsTheme.white.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(25)),
              child: Icon(
                Icons.add,
                color: ColorsTheme.black.withOpacity(0.8),
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
    else
      return ListView.builder(
          controller: popMenuController.scrollController,
          padding: EdgeInsets.symmetric(horizontal: DefaultSize.defaultPadding),
          // physics: NeverScrollableScrollPhysics(),
          itemCount: questionListController.questionBankList.length,
          itemBuilder: (context, index) {
            final GlobalKey btnKey = GlobalKey();
            var item = questionListController.questionBankList[index];
            return QuestionBank(
              btnKey: btnKey,
              lcObject: item,
            );
          });
  }
}
