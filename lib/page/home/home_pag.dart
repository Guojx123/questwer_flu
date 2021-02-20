import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:questwer_flu/controller/pop_menu_controller.dart';
import 'package:questwer_flu/controller/question_list_controller.dart';
import 'package:questwer_flu/model/question_bank.dart';
import 'package:questwer_flu/service/key_value.dart';
import 'package:questwer_flu/theme/color.dart';
import 'package:questwer_flu/theme/size.dart';
import 'package:questwer_flu/util/shared_preferences.dart';
import 'package:questwer_flu/widget/background_widget.dart';
import 'package:questwer_flu/widget/question_bank.dart';
import 'package:questwer_flu/widget/scroll__behavior.dart';
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
            bgColor: Color(0xac96d9ff),
          ),
          _buildCustomScrollView(),
          GestureDetector(
            onTap: () {
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
  Widget _buildCustomScrollView(){
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
                    controller:
                    questionListController.refreshController,
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

  Widget _buildNestedScrollView(){
    return NestedScrollView(
      key: UniqueKey(),
      headerSliverBuilder:
          (BuildContext context, bool innerBoxIsScrolled) {
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
                controller:
                questionListController.refreshController,
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

  _addRefresh() {
    return _addRefreshValue;
  }
}
