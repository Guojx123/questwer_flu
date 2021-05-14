// To parse this JSON data, do
//
//     final questionBank = questionBankFromJson(jsonString);

import 'dart:convert';

QuestionBank questionBankFromJson(String str) =>
    QuestionBank.fromJson(json.decode(str));

String questionBankToJson(QuestionBank data) => json.encode(data.toJson());

class QuestionBank {
  QuestionBank({
    this.description,
    this.acl,
    this.name,
    this.share,
    this.id,
    this.owner,
    this.shareId,
    this.toShareId,
    this.objectId,
    this.createdAt,
    this.updatedAt,
  });

  String description;
  Acl acl;
  String name;
  String share;
  int id;
  String owner;
  String shareId;
  num toShareId;
  String objectId;
  DateTime createdAt;
  DateTime updatedAt;

  factory QuestionBank.fromJson(Map<String, dynamic> json) => QuestionBank(
        description: json["description"],
        acl: Acl.fromJson(json["ACL"]),
        name: json["name"],
        share: json["share"],
        id: json["id"] as int,
        owner: json["owner"],
        shareId: json["shareId"],
        toShareId: json['toShareId'] as num,
        objectId: json["objectId"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "description": description,
        "ACL": acl.toJson(),
        "name": name,
        "share": share,
        "id": id,
        "owner": owner,
        "shareId": shareId,
        "toShareId": toShareId,
        "objectId": objectId,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
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
