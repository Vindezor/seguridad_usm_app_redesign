// To parse this JSON data, do
//
//     final routesModel = routesModelFromJson(jsonString);

import 'dart:convert';

import 'package:test_design/models/stops_model.dart';

RoutesModel routesModelFromJson(String str) => RoutesModel.fromJson(json.decode(str));

String routesModelToJson(RoutesModel data) => json.encode(data.toJson());

class RoutesModel {
    String status;
    String? msg;
    List<Route>? data;

    RoutesModel({
        required this.status,
        required this.msg,
        required this.data,
    });

    factory RoutesModel.fromJson(Map<String, dynamic> json) => RoutesModel(
        status: json["status"],
        msg: json["msg"],
        data: json["data"] != null ? List<Route>.from(json["data"].map((x) => Route.fromJson(x))) : null,
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
        "data": data != null ? List<dynamic>.from(data!.map((x) => x.toJson())) : null,
    };
}

class Route {
    int id;
    String route;
    Stop arrival;
    Stop departure;

    Route({
        required this.id,
        required this.route,
        required this.arrival,
        required this.departure,
    });

    factory Route.fromJson(Map<String, dynamic> json) => Route(
        id: json["id"],
        route: json["route"],
        arrival: Stop.fromJson(json["arrival"]),
        departure: Stop.fromJson(json["departure"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "route": route,
        "arrival": arrival.toJson(),
        "departure": departure.toJson(),
    };
}