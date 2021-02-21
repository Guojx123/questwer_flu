import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:leancloud_storage/leancloud.dart';

class ApiService {
  static var client = http.Client();

  static fetchQuestionList() async {
    LCQuery<LCObject> query = LCQuery('question_bank');
    query.whereEqualTo('owner', 'Q&A');
    List<LCObject> questionBankList = await query.find();
    return questionBankList;
  }

  static fetchQuestion(String name) async {
    LCQuery<LCObject> query = LCQuery('question');
    query.whereEqualTo('ownedQB', name);
    List<LCObject> questionList = await query.find();
    return questionList;
  }
}
