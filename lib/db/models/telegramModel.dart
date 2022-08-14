import 'dart:convert';

TelegramModel telegramModelFromJson(String str) => TelegramModel.fromJson(json.decode(str));

String telegramModelToJson(TelegramModel data) => json.encode(data.toJson());

class TelegramModel {
  TelegramModel({
    this.message,
    this.groups,
  });

  String? message;
  List<Group>? groups;

  factory TelegramModel.fromJson(Map<String, dynamic> json) => TelegramModel(
    message: json["message"],
    groups: List<Group>.from(json["groups"].map((x) => Group.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "groups": List<dynamic>.from(groups!.map((x) => x.toJson())),
  };
}

class Group {
  Group({
    this.id,
    this.name,
    this.link
  });

  int? id;
  String? name;
  String? link;

  factory Group.fromJson(Map<String, dynamic> json) => Group(
    id: json["id"],
    name: json["name"],
    link: json["link"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "link": link
  };
}
