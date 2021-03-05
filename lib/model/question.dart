// To parse this JSON data, do
//
//     final question = questionFromJson(jsonString);

import 'dart:convert';

Question questionFromJson(String str) => Question.fromJson(json.decode(str));

String questionToJson(Question data) => json.encode(data.toJson());

class Question {
  Question({
    this.incorrect_answers,
    this.correctAnswer,
    this.creator,
    this.difficulty,
    this.ownedQb,
    this.subTitle,
    this.title,
    this.id,
    this.objectId,
    this.createdAt,
    this.updatedAt,
    this.acl,
  });

  String incorrect_answers;
  String correctAnswer;
  String creator;
  String difficulty;
  String ownedQb;
  String subTitle;
  String title;
  int id;
  String objectId;
  DateTime createdAt;
  DateTime updatedAt;
  Acl acl;

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        incorrect_answers: json["incorrect_answers"],
        correctAnswer: json["correct_answer"],
        creator: json["creator"],
        difficulty: json["difficulty"],
        ownedQb: json["ownedQB"],
        subTitle: json["sub_title"],
        title: json["title"],
        id: json["id"],
        objectId: json["objectId"],
        createdAt:
            DateTime.parse(json["createdAt"] ?? DateTime.now().toString()),
        updatedAt:
            DateTime.parse(json["updatedAt"] ?? DateTime.now().toString()),
        acl: Acl.fromJson(json["ACL"] ??
            {
              "*": {"read": true},
            }),
      );

  Map<String, dynamic> toJson() => {
        "answer": incorrect_answers,
        "correct_answer": correctAnswer,
        "creator": creator,
        "difficulty": difficulty,
        "ownedQB": ownedQb,
        "sub_title": subTitle,
        "title": title,
        "id": id,
        "objectId": objectId,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "ACL": acl.toJson(),
      };
}

class Acl {
  Acl({
    this.empty,
  });

  Empty empty;

  factory Acl.fromJson(Map<String, dynamic> json) => Acl(
        empty: Empty.fromJson(json["*"]),
      );

  Map<String, dynamic> toJson() => {
        "*": empty.toJson(),
      };
}

class Empty {
  Empty({
    this.read,
  });

  bool read;

  factory Empty.fromJson(Map<String, dynamic> json) => Empty(
        read: json["read"],
      );

  Map<String, dynamic> toJson() => {
        "read": read,
      };
}
