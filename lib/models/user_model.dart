import 'dart:convert';

import 'package:test_design/models/login_model.dart';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    String status;
    String msg;
    Data? data;

    UserModel({
        required this.status,
        required this.msg,
        required this.data,
    });

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        status: json["status"],
        msg: json["msg"],
        data: json["data"] != null ? Data.fromJson(json["data"]) : null,
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
        "data": data != null ? data!.toJson() : null,
    };
}

class Data {
    User user;

    Data({
        required this.user,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        user: User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "user": user.toJson(),
    };
}