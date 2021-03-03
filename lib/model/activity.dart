// To parse this JSON data, do
//
//     final activity = activityFromJson(jsonString);

import 'dart:convert';

Activity activityFromJson(String str) => Activity.fromJson(json.decode(str));

String activityToJson(Activity data) => json.encode(data.toJson());

class Activity {
  Activity({
    this.acl,
    this.subTitle,
    this.title,
    this.imgUrl,
    this.isEnable,
    this.updatedAt,
    this.objectId,
    this.createdAt,
    this.type,
    this.id,
  });

  Acl acl;
  String subTitle;
  String title;
  String imgUrl;
  bool isEnable;
  DateTime updatedAt;
  String objectId;
  DateTime createdAt;
  String type;
  int id;

  factory Activity.fromJson(Map<String, dynamic> json) => Activity(
    acl: Acl.fromJson(json["ACL"]),
    subTitle: json["subTitle"],
    title: json["title"],
    imgUrl: json["imgUrl"],
    isEnable: json["isEnable"],
    updatedAt: DateTime.parse(json["updatedAt"]),
    objectId: json["objectId"],
    createdAt: DateTime.parse(json["createdAt"]),
    type: json["type"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "ACL": acl.toJson(),
    "subTitle": subTitle,
    "title": title,
    "imgUrl": imgUrl,
    "isEnable": isEnable,
    "updatedAt": updatedAt.toIso8601String(),
    "objectId": objectId,
    "createdAt": createdAt.toIso8601String(),
    "type": type,
    "id": id,
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
