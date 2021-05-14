import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:questwer_flu/controller/pop_menu_controller.dart';
import 'package:questwer_flu/controller/question_list_controller.dart';
import 'package:questwer_flu/model/question_bank.dart';
import 'package:questwer_flu/theme/size.dart';
import 'package:questwer_flu/util/shared_preferences.dart';
import 'package:questwer_flu/widget/question_item.dart';
import 'package:questwer_flu/widget/smart_refresh_footer.dart';

class QuestionBankList extends StatefulWidget {

  final String questionBankOwner;

  const QuestionBankList(this.questionBankOwner);

  @override
  _QuestionBankListState createState() => _QuestionBankListState();
}

class _QuestionBankListState extends State<QuestionBankList> {

  final PopMenuController _popMenuController = Get.put(PopMenuController());
  final QuestionListController _questionListController =
  Get.put(QuestionListController());
  String get _owner => widget.questionBankOwner; // Admin: Q&A

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _questionListController.fetchQuestionBank(_owner);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuestionListController>(
        init: QuestionListController(),
        builder: (controller) {
          return SmartRefresher(
            physics: BouncingScrollPhysics(),
            controller: _questionListController.refreshController,
            enablePullDown: true,
            enablePullUp: false,
            onRefresh: () {
              _questionListController.refreshList(_owner);
              _questionListController.refreshController.refreshCompleted();
              _questionListController.refreshController.loadComplete();
            },
            onLoading: () {
              _questionListController.refreshController.loadComplete();
            },
            footer: RefreshFooter(),
            child: _questionListController.questionBankList.isEmpty ? Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/empty_question_list.png",
                    width: DefaultSize.largeSize * 5,
                    height: DefaultSize.largeSize * 5,
                  ),
                  Text('common.no_found_question'.tr,style: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: DefaultSize.fontSize,
                  ),)
                ],
              ),
            ):_buildList(controller.isLoading.value),
          );
        });
  }

  Widget _buildList(bool isLoading) {
    if (isLoading)
      return Center(
        child: CircularProgressIndicator(),
      );
    else {
      return Padding(
        padding: EdgeInsets.only(top: PersistentStorage.topHeight * 2.8),
        child: ListView.builder(
            controller: _popMenuController.scrollController,
            padding:
            EdgeInsets.symmetric(horizontal: DefaultSize.defaultPadding),
            physics: NeverScrollableScrollPhysics(),
            itemCount: _questionListController.questionBankList.length,
            itemBuilder: (context, index) {
              final GlobalKey btnKey = GlobalKey();
              List<QuestionBank> questionBank =
              _questionListController.questionBankList
                  .map((item) => QuestionBank(
                id: item["id"],
                name: item["name"],
                description: item["description"],
                // LCObject.objectId 需要get方法获取
                objectId: item.objectId,
                share: item["share"],
                owner: item["owner"],
                shareId: item["shareId"],
              ))
                  .toList();
              var item = questionBank[index];
              return QuestionBankItem(
                btnKey: btnKey,
                questionBank: item,
              );
            }),
      );
    }
  }
}
