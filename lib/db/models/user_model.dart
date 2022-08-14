// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.user,
    this.status,
  });

  User? user;
  int? status;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        user: User.fromJson(json["user"]),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "user": user!.toJson(),
        "status": status,
      };
}

class User {
  User({
    this.id,
    this.uid,
    this.email,
    this.username,
    this.loggedIn,
    this.deviceId,
    this.token,
    this.lastLogin,
    this.password,
    this.paymentCurrency,
    this.lastPayment,
    this.payment,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? uid;
  String? email;
  String? username;
  bool? loggedIn;
  String? deviceId;
  String? token;
  String? lastLogin;
  String? password;
  dynamic paymentCurrency;
  dynamic lastPayment;
  dynamic payment;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        uid: json["uid"],
        email: json["email"],
        username: json["username"],
        loggedIn: json["loggedIn"],
        deviceId: json["deviceId"],
        token: json["token"],
        lastLogin: json["lastLogin"],
        password: json["password"],
        paymentCurrency: json["paymentCurrency"],
        lastPayment: json["lastPayment"],
        payment: json["payment"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uid": uid,
        "email": email,
        "username": username,
        "loggedIn": loggedIn,
        "deviceId": deviceId,
        "token": token,
        "lastLogin": lastLogin,
        "password": password,
        "paymentCurrency": paymentCurrency,
        "lastPayment": lastPayment,
        "payment": payment,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}
