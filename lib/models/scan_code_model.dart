// To parse this JSON data, do
//
//     final scanCodeModel = scanCodeModelFromJson(jsonString);

// ignore_for_file: prefer_null_aware_operators

import 'dart:convert';

ScanCodeModel scanCodeModelFromJson(String str) => ScanCodeModel.fromJson(json.decode(str));

String scanCodeModelToJson(ScanCodeModel data) => json.encode(data.toJson());

class ScanCodeModel {
    String status;
    String msg;
    Data? data;

    ScanCodeModel({
        required this.status,
        required this.msg,
        required this.data,
    });

    factory ScanCodeModel.fromJson(Map<String, dynamic> json) => ScanCodeModel(
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
    int idTravel;

    Data({
        required this.idTravel,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        idTravel: json["id_travel"],
    );

    Map<String, dynamic> toJson() => {
        "id_travel": idTravel,
    };
}
