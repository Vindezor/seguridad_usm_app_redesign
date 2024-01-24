import 'dart:convert';

import 'package:test_design/models/travel_model.dart';

BrandsModel stopsModelFromJson(String str) => BrandsModel.fromJson(json.decode(str));

String stopsModelToJson(BrandsModel data) => json.encode(data.toJson());

class BrandsModel {
    String status;
    String? msg;
    List<Brand>? data;

    BrandsModel({
        required this.status,
        required this.msg,
        required this.data,
    });

    factory BrandsModel.fromJson(Map<String, dynamic> json) => BrandsModel(
        status: json["status"],
        msg: json["msg"],
        data: json["data"] != null ? List<Brand>.from(json["data"].map((x) => Brand.fromJson(x))) : null,
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
        "data": data != null ? List<dynamic>.from(data!.map((x) => x.toJson())) : null,
    };
}