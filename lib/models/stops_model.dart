// To parse this JSON data, do
//
//     final stopsModel = stopsModelFromJson(jsonString);

import 'dart:convert';

StopsModel stopsModelFromJson(String str) => StopsModel.fromJson(json.decode(str));

String stopsModelToJson(StopsModel data) => json.encode(data.toJson());

class StopsModel {
    String status;
    String? msg;
    List<Stop>? data;

    StopsModel({
        required this.status,
        required this.msg,
        required this.data,
    });

    factory StopsModel.fromJson(Map<String, dynamic> json) => StopsModel(
        status: json["status"],
        msg: json["msg"],
        data: json["data"] != null ? List<Stop>.from(json["data"].map((x) => Stop.fromJson(x))) : null,
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
        "data": data != null ? List<dynamic>.from(data!.map((x) => x.toJson())) : null,
    };
}

class Stop {
    int id;
    String name;
    String coordinate;

    Stop({
        required this.id,
        required this.name,
        required this.coordinate,
    });

    factory Stop.fromJson(Map<String, dynamic> json) => Stop(
        id: json["id"],
        name: json["name"],
        coordinate: json["coordinate"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "coordinate": coordinate,
    };
}
