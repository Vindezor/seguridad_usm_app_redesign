// To parse this JSON data, do
//
//     final genericModel = genericModelFromJson(jsonString);

import 'dart:convert';

GenericModel genericModelFromJson(String str) => GenericModel.fromJson(json.decode(str));

String genericModelToJson(GenericModel data) => json.encode(data.toJson());

class GenericModel {
    String status;
    String msg;

    GenericModel({
        required this.status,
        required this.msg,
    });

    factory GenericModel.fromJson(Map<String, dynamic> json) => GenericModel(
        status: json["status"],
        msg: json["msg"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
    };
}
