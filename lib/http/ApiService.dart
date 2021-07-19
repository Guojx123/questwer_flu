import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:leancloud_storage/leancloud.dart';
import 'package:questwer_flu/model/question_by_category.dart';

import 'question.dart';


class ApiService {
  static var client;

  ApiService(){
    client = http.Client();
  }

  /// 查询所有活动
  static fetchActivityList() async {
    LCQuery<LCObject> query = LCQuery('activity');
    List<LCObject> activityList = await query.find();
    return activityList;
  }

  /// 获取题库的所有者
  static getQuestionListOwner() async {
    LCUser currentUser = await LCUser.getCurrent();
    return currentUser.username;
  }

  /// 根据条件查询题库
  static fetchQuestionList(String owner) async {
    LCQuery<LCObject> query = LCQuery('question_bank');
    query.whereEqualTo('owner', owner ?? 'Q&A'); // 筛选出Q&A（官方）的题库
    query.whereEqualTo('enable', true); // 筛选出启用的题库
    List<LCObject> questionBankList = await query.find();
    return questionBankList;
  }

  /// 根据题库名称查询题目
  static fetchQuestion(String name) async {
    LCQuery<LCObject> query = LCQuery('question');
    query.whereEqualTo('ownedQB', name);
    List<LCObject> questionList = await query.find();
    return questionList;
  }

  /// 查询所有分类
  static fetchCategoryList() async {
    LCQuery<LCObject> query = LCQuery('category');
    List<LCObject> categoryList = await query.find();
    return categoryList;
  }

  /// 根据id删除题库（假删除）
  static deleteQuestionBankByObjectId(String objectId) async {
    LCObject questionBank =
        LCObject.createWithoutData('question_bank', objectId);
    questionBank['enable'] = false;
    await questionBank.save();
  }
}
