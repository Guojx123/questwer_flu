// To parse this JSON data, do
//
//     final question = questionFromJson(jsonString);

import 'dart:convert';

QuestionByCategory questionFromJson(String str) => QuestionByCategory.fromJson(json.decode(str));

String questionToJson(QuestionByCategory data) => json.encode(data.toJson());

class QuestionByCategory {
  QuestionByCategory({
    this.responseCode,
    this.results,
  });

  int responseCode;
  List<Result> results;

  factory QuestionByCategory.fromJson(Map<String, dynamic> json) => QuestionByCategory(
    responseCode: json["response_code"],
    results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "response_code": responseCode,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
  };
}

class Result {
  Result({
    this.category,
    this.type,
    this.difficulty,
    this.question,
    this.correctAnswer,
    this.incorrectAnswers,
  });

  String category;
  Type type;
  Difficulty difficulty;
  String question;
  String correctAnswer;
  List<String> incorrectAnswers;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    category: json["category"],
    type: typeValues.map[json["type"]],
    difficulty: difficultyValues.map[json["difficulty"]],
    question: json["question"],
    correctAnswer: json["correct_answer"],
    incorrectAnswers: List<String>.from(json["incorrect_answers"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "category": category,
    "type": typeValues.reverse[type],
    "difficulty": difficultyValues.reverse[difficulty],
    "question": question,
    "correct_answer": correctAnswer,
    "incorrect_answers": List<dynamic>.from(incorrectAnswers.map((x) => x)),
  };
}

enum Difficulty { EASY, HARD, MEDIUM }

final difficultyValues = EnumValues({
  "easy": Difficulty.EASY,
  "hard": Difficulty.HARD,
  "medium": Difficulty.MEDIUM
});

enum Type { MULTIPLE, BOOLEAN }

final typeValues = EnumValues({
  "boolean": Type.BOOLEAN,
  "multiple": Type.MULTIPLE
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
