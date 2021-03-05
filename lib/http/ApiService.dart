import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:leancloud_storage/leancloud.dart';
import 'package:questwer_flu/model/question.dart';
import 'package:questwer_flu/model/question_by_category.dart';

class ApiService {
  static var client = http.Client();

  static fetchActivityList() async {
    LCQuery<LCObject> query = LCQuery('activity');
    List<LCObject> activityList = await query.find();
    return activityList;
  }

  static getQuestionListOwner() async {
    LCUser currentUser = await LCUser.getCurrent();
    return currentUser.username;
  }

  static fetchQuestionList(String owner) async {
    LCQuery<LCObject> query = LCQuery('question_bank');
    query.whereEqualTo('owner', owner ?? 'Q&A');
    List<LCObject> questionBankList = await query.find();
    return questionBankList;
  }

  static fetchQuestion(String name) async {
    LCQuery<LCObject> query = LCQuery('question');
    query.whereEqualTo('ownedQB', name);
    List<LCObject> questionList = await query.find();
    return questionList;
  }

  static fetchCategoryList() async {
    LCQuery<LCObject> query = LCQuery('category');
    List<LCObject> categoryList = await query.find();
    return categoryList;
  }

  static fetchQuestionByCategory(int categoryId) async {
    var response = await client.get("https://opentdb.com/api.php?amount=10&category=$categoryId");
    if(response.statusCode == 200){
      var jsonString = response.body;
      return QuestionByCategory.fromJson(convert.jsonDecode(jsonString));
    }
  }
}
