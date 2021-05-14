import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:questwer_flu/controller/question_controller.dart';
import 'package:questwer_flu/model/question.dart';
import 'package:questwer_flu/model/question_by_category.dart';
import 'package:questwer_flu/theme/color.dart';
import 'package:questwer_flu/theme/size.dart';
import 'option.dart';

class QuestionCard extends StatefulWidget {
  final String name;
  final bool isLoading;
  final int categoryId;
  final bool isCategory;

  const QuestionCard({Key key, this.name, this.isLoading, this.isCategory, this.categoryId})
      : super(key: key);

  @override
  _QuestionCardState createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  QuestionController _questionController = Get.put(QuestionController());
  List<Question> _question;

  bool get _isCategory => widget.isCategory ?? false;
  int get _categoryId => widget.categoryId;
  String get _name => widget.name;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _question = List();
    _isCategory ? _questionController.fetchQuestionByCategory(_categoryId) :
    _questionController.fetchQuestion(_name);
  }

  @override
  Widget build(BuildContext context) {
    if (_questionController.isLoading.value &&
        _questionController.questionList.length > 0)
      return Center(
        child: CircularProgressIndicator(),
      );
    else
      return Obx(
        () => PageView.builder(
            physics: NeverScrollableScrollPhysics(),
            controller: _questionController.pageController,
            onPageChanged: _questionController.updateTheQnNum,
            itemCount: _questionController.questionList.length,
            itemBuilder: (context, index) => _questionItem(index)),
      );
  }

  Widget _questionItem(int index) {
    List answerList;
    if(_isCategory){
      Result result = _questionController.questionList[index];
      /// 处理二维数组
      // var menuIconMap = [
      //   [
      //     {
      //       'title': '标题111',
      //       // 标题
      //       'desc': '副标题',
      //       // 副标题
      //       'url':
      //       'https://cdnimg.doutian.me/20210412/89951618234773858?imageMogr2/auto-orient',
      //       // 图片url
      //       'eventType': 'url',
      //       // 操作类型: 'url', 'product', 'empty'
      //       'eventConf': 'http://www.baidu.com',
      //       // 对应eventType的操作: 链接,商品id,'',
      //       'evttckTag': 'lgs_123',
      //       //打点数据标识(v2属性)
      //     },
      //   ],
      //   [
      //     {
      //       'title': '标题111',
      //       // 标题
      //       'desc': '副标题',
      //       // 副标题
      //       'url':
      //       'https://cdnimg.doutian.me/20210412/89951618234773858?imageMogr2/auto-orient',
      //       // 图片url
      //       'eventType': 'url',
      //       // 操作类型: 'url', 'product', 'empty'
      //       'eventConf': 'http://www.baidu.com',
      //       // 对应eventType的操作: 链接,商品id,'',
      //       'evttckTag': 'lgs_123',
      //       //打点数据标识(v2属性)
      //     },
      //   ]
      // ];
      // var list = <List<MenuIconModel>>[];
      // menuIconMap.map((e) {
      //   var iconList = <MenuIconModel>[];
      //   e.map((e) {
      //     iconList.add(MenuIconModel.fromString(e['title'], e['desc'], e['url'],
      //         e['eventType'], e['eventConf'], e['evttckTag']));
      //   }).toList();
      //   list.add(iconList);
      // }).toList();
      print(result.question);
      List<Question> questionList = [];
      for(int i = 0 ; i < _questionController.questionList.length ; i++){
        questionList.add(Question(
          id: 1,
          title: result.question ?? '',
          subTitle: '',
          difficulty: '',
          incorrectAnswers: json.encode(result.incorrectAnswers),
          correctAnswer: result.correctAnswer,
          ownedQb: '',
          creator: '',
        ));
      }
      _question = questionList;
    }else{
      _question = _questionController.questionList
          .map((item) => Question(
        id: item["id"] ?? 1,
        title: item["title"] ?? '',
        subTitle: item["sub_title"] ?? '',
        difficulty: item["difficulty"] ?? '',
        incorrectAnswers: item["incorrect_answers"],
        correctAnswer: item["correct_answer"],
        ownedQb: item["ownedQB"] ?? '',
        creator: item["creator"] ?? '',
      )).toList();
    }

    Question item = _question[index];

    /// 解析json字符串
    if(_isCategory){
      answerList = json.decode(item.incorrectAnswers);
      answerList.add(item.correctAnswer);
    }else{
      answerList = json.decode(item.incorrectAnswers);
    }

    /// 打乱顺序
    answerList.shuffle();

    /// 直接使用数组，不需要解析
//    List answerList = item.answer;
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: DefaultSize.defaultPadding,
          vertical: DefaultSize.defaultPadding),
      padding: EdgeInsets.all(DefaultSize.defaultPadding),
      decoration: BoxDecoration(
        color: ColorsTheme.white.withOpacity(0.94),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        children: [
          SizedBox(
            height: DefaultSize.middleSize,
          ),
          ListTile(
            title: Text(
              item.title,
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  .copyWith(color: ColorsTheme.black),
            ),
            subtitle: Text(
              item.subTitle,
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  .copyWith(color: ColorsTheme.black),
            ),
          ),
          SizedBox(height: DefaultSize.defaultPadding / 2),
          ...List.generate(
            answerList?.length ?? 0,
            (index) => Option(
              index: index,
              text: answerList[index],
              press: () =>
                  _questionController.checkAns(item, answerList[index]),
            ),
          ),
        ],
      ),
    );
  }
}
