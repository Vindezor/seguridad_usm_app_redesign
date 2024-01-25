import 'package:test_design/models/travel_model.dart';

class TravelsModel {
    String status;
    String? msg;
    List<Travel>? data;

    TravelsModel({
        required this.status,
        required this.msg,
        required this.data,
    });

    factory TravelsModel.fromJson(Map<String, dynamic> json) => TravelsModel(
        status: json["status"],
        msg: json["msg"],
        data: json["data"] != null ? List<Travel>.from(json["data"].map((x) => Travel.fromJson(x))) : null,
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
        "data": data != null ? List<dynamic>.from(data!.map((x) => x.toJson())) : null,
    };
}