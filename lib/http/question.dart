import 'package:dio/dio.dart';
import 'dart:convert' as convert;
import 'package:questwer_flu/model/question_by_category.dart';

class QuestionApi {
  Dio _httpClient;

  QuestionApi() {
    var options = BaseOptions(
      baseUrl: 'https://opentdb.com/api.php',
      connectTimeout: 10 * 1000,
    );
    _httpClient = Dio(options);
  }

  Future<QuestionByCategory> getQuestion(int categoryId) async {
    var response = await _httpClient.get(
      'https://opentdb.com/api.php',
      queryParameters: {
        'amount': 10,
        'category': categoryId,
      },
    );
    if (response.statusCode == 200) {
      var jsonString = response.data;
      return QuestionByCategory.fromJson(convert.jsonDecode(jsonString));
    }
  }
}
