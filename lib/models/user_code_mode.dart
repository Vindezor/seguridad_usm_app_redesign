// To parse this JSON data, do
//
//     final userCodeModel = userCodeModelFromJson(jsonString);
import 'dart:convert';

UserCodeModel userCodeModelFromJson(String str) => UserCodeModel.fromJson(json.decode(str));

String userCodeModelToJson(UserCodeModel data) => json.encode(data.toJson());

class UserCodeModel {
    String status;
    String msg;
    Data? data;

    UserCodeModel({
        required this.status,
        required this.msg,
        required this.data,
    });

    factory UserCodeModel.fromJson(Map<String, dynamic> json) => UserCodeModel(
        status: json["status"],
        msg: json["msg"],
        data: json["data"] != null ? Data.fromJson(json["data"]) : null,
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
        "data": data != null ? data?.toJson() : null,
    };
}

class Data {
    String code;

    Data({
        required this.code,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        code: json["code"],
    );

    Map<String, dynamic> toJson() => {
        "code": code,
    };
}
