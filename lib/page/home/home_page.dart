import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:questwer_flu/controller/pop_menu_controller.dart';
import 'package:questwer_flu/controller/question_list_controller.dart';
import 'package:questwer_flu/model/question_bank.dart';
import 'package:questwer_flu/page/add/my_slider.dart';
import 'package:questwer_flu/page/add/my_text_field.dart';
import 'package:questwer_flu/page/add/question_bank_textfield.dart';
import 'package:questwer_flu/service/key_value.dart';
import 'package:questwer_flu/service/my_text_editing_controller.dart';
import 'package:questwer_flu/service/scroll__behavior.dart';
import 'package:questwer_flu/theme/color.dart';
import 'package:questwer_flu/theme/size.dart';
import 'package:questwer_flu/util/shared_preferences.dart';
import 'package:questwer_flu/widget/background_widget.dart';
import 'package:questwer_flu/widget/custom_shape.dart';
import 'package:questwer_flu/widget/question_bank.dart';
import 'package:questwer_flu/widget/smart_refresh_footer.dart';

class HomePage extends StatelessWidget {
  PopMenuController popMenuController = Get.put(PopMenuController());
  QuestionListController questionListController =
      Get.put(QuestionListController());

  bool _addRefreshValue = true;

  ///是否添加刷新

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          BackGroundWidget(
            blur: 0.0,
            // bgColor: Color(0xac96d9ff),
          ),
          _buildCustomScrollView(),
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

  Widget _buildCustomScrollView() {
    return Container(
      key: UniqueKey(),
      width: double.infinity,
      child: ScrollConfiguration(
        behavior: OverScrollBehavior(),
        child: GetBuilder(
          init: QuestionListController(),
          builder: (context) {
            return _addRefresh()
                ? Column(
                    children: [
                      AppBar(
                        backgroundColor: Colors.transparent,
                        automaticallyImplyLeading: false,
                        toolbarHeight: DefaultSize.defaultPadding * 4,
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
                              child: Icon(
                                Icons.settings,
                                color: ColorsTheme.white,
                              ))
                        ],
                      ),
                      Expanded(
                        child: SmartRefresher(
                          physics: BouncingScrollPhysics(),
                          controller: questionListController.refreshController,
                          enablePullDown: true,
                          enablePullUp: false,
                          onRefresh: () {
                            questionListController.refreshList();
                            questionListController.refreshController
                                .refreshCompleted();
                            questionListController.refreshController
                                .loadComplete();
                          },
                          onLoading: () {
                            questionListController.refreshController
                                .loadComplete();
                          },
                          // header: WaterDropMaterialHeader(
                          //   backgroundColor: ColorsTheme.primaryColor,
                          //   distance: 30,
                          // ),
                          footer: RefreshFooter(),
                          child: _buildList(
                              questionListController.isLoading.value),
                        ),
                      )
                    ],
                  )
                : _buildList(questionListController.isLoading.value);
          },
        ),
      ),
    );
  }

  Widget _buildNestedScrollView() {
    return NestedScrollView(
      key: UniqueKey(),
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: false,
            toolbarHeight: DefaultSize.defaultPadding * 4,
            brightness: Brightness.dark,
            elevation: 0,
            floating: true,
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
                  child: Icon(
                    Icons.settings,
                    color: ColorsTheme.white,
                  ))
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
              return _addRefresh()
                  ? SmartRefresher(
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
                    )
                  : _buildList(questionListController.isLoading.value);
            },
          ),
        ),
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
          });
  }

  bool _addRefresh() {
    return _addRefreshValue;
  }

  void _createQB() {
    Get.bottomSheet(
      ScrollConfiguration(
        behavior: OverScrollBehavior(),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: DefaultSize.defaultPadding * 2,
              vertical: DefaultSize.defaultPadding),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: rTagGreyColor,
                      borderRadius:
                          BorderRadius.circular(DefaultSize.middleSize)),
                  width: DefaultSize.largeSize,
                  height: DefaultSize.smallSize,
                ),
                ///topNav
                Container(
                  margin:
                      EdgeInsets.symmetric(vertical: DefaultSize.middleSize),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.all(DefaultSize.smallSize * 1.2),
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(DefaultSize.middleSize),
                        ),
                        child: Icon(
                          Icons.read_more,
                          color: rDeepPurpleColor,
                          size: DefaultSize.smallSize * 6,
                        ),
                      ),
                      Text(
                        "",
                        style: TextStyle(
                            color: rDeepPurpleColor,
                            fontSize: DefaultSize.middleFontSize),
                      ),
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          padding: EdgeInsets.all(DefaultSize.smallSize * 1.2),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(DefaultSize.middleSize),
                            color: rLightPurpleColor.withOpacity(0.8),
                          ),
                          child: Icon(
                            Icons.close,
                            color: rDeepPurpleColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                ///desc
                _buildInstruction(),

                ///choose or form
                AddTextFieldWidget(),
                _buildDifficulty(),
                MySlider(),
                SizedBox(
                  height: DefaultSize.defaultPadding,
                ),

                ///btn
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: DefaultSize.defaultPadding * 8,
                        vertical: DefaultSize.defaultPadding * 1.4),
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(DefaultSize.largeSize / 2),
                      color: rLightPurpleColor.withOpacity(0.8),
                    ),
                    child: Text(
                      "Continue",
                      style: TextStyle(
                        color: rDeepPurpleColor,
                        fontSize: DefaultSize.smallFontSize,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      shape: CustomRoundedRectangleBorder(
        // borderRadius: BorderRadius.vertical(
        //     top: Radius.circular(DefaultSize.middleSize * 2)),
        borderRadius: BorderRadius.circular(25.0),
        borderWidth: 10.0,
        bgColor: rMiddlePurpleColor,
      ),
      elevation: 0,
      backgroundColor: rMiddlePurpleColor,
      isScrollControlled: true,
    );
  }

  Widget _buildInstruction() {
    return _buildTitleWidget(
      Text(
        "Add a description to your new question bank.",
        style: TextStyle(color: Color(0xFF979796), fontSize: 13, height: 1.5),
      ),
      title: "Create Question Bank",
    );
  }

  Widget _buildDifficulty() {
    return _buildTitleWidget(
      Text(
        "Set overall difficulty for your question bank.",
        style: TextStyle(color: Color(0xFF979796), fontSize: 13, height: 1.5),
      ),
      title: "Set difficulty",
    );
  }

  Widget _buildTitleWidget(Widget content, {String title}) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(
          horizontal: DefaultSize.defaultPadding,
          vertical: DefaultSize.defaultPadding),
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.6),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$title",
            style: TextStyle(
                height: 1.6,
                color: ColorsTheme.black,
                fontSize: DefaultSize.middleFontSize,
                fontWeight: FontWeight.w500),
          ),
          content
        ],
      ),
    );
  }
}
