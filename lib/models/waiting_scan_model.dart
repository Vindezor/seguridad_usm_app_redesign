// To parse this JSON data, do
//
//     final genericModel = genericModelFromJson(jsonString);

import 'dart:convert';

WaitingScanModel waitingScanModelFromJson(String str) => WaitingScanModel.fromJson(json.decode(str));

String waitingScanModelToJson(WaitingScanModel data) => json.encode(data.toJson());

class WaitingScanModel {
    String status;
    String msg;
    Data? data;

    WaitingScanModel({
        required this.status,
        required this.msg,
        required this.data,
    });

    factory WaitingScanModel.fromJson(Map<String, dynamic> json) => WaitingScanModel(
        status: json["status"],
        msg: json["msg"],
        data: json["data"] != null ? Data.fromJson(json["data"]) : null
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
    };
}

class Data {
    String idTravel;

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

