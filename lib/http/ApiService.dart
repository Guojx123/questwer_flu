import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:leancloud_storage/leancloud.dart';
import 'package:questwer_flu/model/question_bank.dart';

class ApiService {

  static var client = http.Client();

  static fetchQuestion() async {
    LCQuery<LCObject> query = LCQuery('question_bank');
    query.whereEqualTo('owner', 'Q&A');
    List<LCObject> questionBankList = await query.find();
    return questionBankList;
  }

}