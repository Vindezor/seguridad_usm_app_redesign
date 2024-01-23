import 'dart:convert';

import 'package:test_design/models/travel_model.dart';

UnitsModel stopsModelFromJson(String str) => UnitsModel.fromJson(json.decode(str));

String stopsModelToJson(UnitsModel data) => json.encode(data.toJson());

class UnitsModel {
    String status;
    String? msg;
    List<Unit>? data;

    UnitsModel({
        required this.status,
        required this.msg,
        required this.data,
    });

    factory UnitsModel.fromJson(Map<String, dynamic> json) => UnitsModel(
        status: json["status"],
        msg: json["msg"],
        data: json["data"] != null ? List<Unit>.from(json["data"].map((x) => Unit.fromJson(x))) : null,
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
        "data": data != null ? List<dynamic>.from(data!.map((x) => x.toJson())) : null,
    };
}