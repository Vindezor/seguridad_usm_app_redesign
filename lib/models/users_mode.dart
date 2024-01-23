import 'dart:convert';

import 'package:test_design/models/login_model.dart';

UsersModel usersModelFromJson(String str) => UsersModel.fromJson(json.decode(str));

String usersModelToJson(UsersModel data) => json.encode(data.toJson());

class UsersModel {
  String status;
  String? msg;
  List<User>? data;

  UsersModel({
      required this.status,
      required this.msg,
      required this.data,
  });

  factory UsersModel.fromJson(Map<String, dynamic> json) => UsersModel(
      status: json["status"],
      msg: json["msg"],
      data: json["data"] != null ? List<User>.from(json["data"].map((x) => User.fromJson(x))) : null,
  );

  Map<String, dynamic> toJson() => {
      "status": status,
      "msg": msg,
      "data": data != null ? List<dynamic>.from(data!.map((x) => x.toJson())) : null,
  };
}