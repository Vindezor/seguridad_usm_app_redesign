import 'dart:convert';

import 'package:test_design/models/travel_model.dart';

ModelsModel stopsModelFromJson(String str) => ModelsModel.fromJson(json.decode(str));

String stopsModelToJson(ModelsModel data) => json.encode(data.toJson());

class ModelsModel {
    String status;
    String? msg;
    List<Model>? data;

    ModelsModel({
        required this.status,
        required this.msg,
        required this.data,
    });

    factory ModelsModel.fromJson(Map<String, dynamic> json) => ModelsModel(
        status: json["status"],
        msg: json["msg"],
        data: json["data"] != null ? List<Model>.from(json["data"].map((x) => Model.fromJson(x))) : null,
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
        "data": data != null ? List<dynamic>.from(data!.map((x) => x.toJson())) : null,
    };
}