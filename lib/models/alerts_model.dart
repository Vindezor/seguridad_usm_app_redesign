// To parse this JSON data, do
//
//     final alertsModel = alertsModelFromJson(jsonString);

import 'dart:convert';

import 'package:test_design/models/login_model.dart';

AlertsModel alertsModelFromJson(String str) => AlertsModel.fromJson(json.decode(str));

String alertsModelToJson(AlertsModel data) => json.encode(data.toJson());

class AlertsModel {
    String status;
    String? msg;
    List<Alert> data;

    AlertsModel({
        required this.status,
        required this.msg,
        required this.data,
    });

    factory AlertsModel.fromJson(Map<String, dynamic> json) => AlertsModel(
        status: json["status"],
        msg: json["msg"],
        data: List<Alert>.from(json["data"].map((x) => Alert.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Alert {
    int id;
    DateTime time;
    int idUser;
    int idTravel;
    User user;

    Alert({
        required this.id,
        required this.time,
        required this.idUser,
        required this.idTravel,
        required this.user,
    });

    factory Alert.fromJson(Map<String, dynamic> json) => Alert(
        id: json["id"],
        time: DateTime.parse(json["time"]).toLocal(),
        idUser: json["id_user"],
        idTravel: json["id_travel"],
        user: User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "time": time.toIso8601String(),
        "id_user": idUser,
        "id_travel": idTravel,
        "user": user.toJson(),
    };
}