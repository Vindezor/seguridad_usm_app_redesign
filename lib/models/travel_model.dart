// To parse this JSON data, do
//
//     final travelModel = travelModelFromJson(jsonString);

// ignore_for_file: prefer_null_aware_operators

import 'dart:convert';

import 'package:test_design/models/stops_model.dart';

TravelModel travelModelFromJson(String str) => TravelModel.fromJson(json.decode(str));

String travelModelToJson(TravelModel data) => json.encode(data.toJson());

class TravelModel {
    String status;
    String? msg;
    Data? data;

    TravelModel({
        required this.status,
        required this.msg,
        required this.data,
    });

    factory TravelModel.fromJson(Map<String, dynamic> json) => TravelModel(
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
    int id;
    String coordinate;
    DateTime startTime;
    DateTime? endTime;
    int idUnit;
    int idRoute;
    Unit unit;
    Route route;

    Data({
        required this.id,
        required this.coordinate,
        required this.startTime,
        required this.endTime,
        required this.idUnit,
        required this.idRoute,
        required this.unit,
        required this.route,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        coordinate: json["coordinate"],
        startTime: DateTime.parse(json["start_time"]),
        endTime: json["end_time"] != null ? DateTime.parse(json["start_time"]) : null,
        idUnit: json["id_unit"],
        idRoute: json["id_route"],
        unit: Unit.fromJson(json["unit"]),
        route: Route.fromJson(json["route"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "coordinate": coordinate,
        "start_time": startTime.toIso8601String(),
        "end_time": endTime != null ? endTime!.toIso8601String() : null,
        "id_unit": idUnit,
        "id_route": idRoute,
        "unit": unit.toJson(),
        "route": route.toJson(),
    };
}

class Driver {
    int id;
    String? document;
    String? password;
    String? email;
    String? universityCode;
    DateTime? expirationDate;
    String? fullName;
    String? emergencyEmail;
    DateTime? creationDate;
    bool isActive;
    String? emergencyPhone;
    String? phone;
    int idTypeUser;

    Driver({
        required this.id,
        required this.document,
        required this.password,
        required this.email,
        required this.universityCode,
        required this.expirationDate,
        required this.fullName,
        required this.emergencyEmail,
        required this.creationDate,
        required this.isActive,
        required this.emergencyPhone,
        required this.phone,
        required this.idTypeUser,
    });

    factory Driver.fromJson(Map<String, dynamic> json) => Driver(
        id: json["id"],
        document: json["document"],
        password: json["password"],
        email: json["email"],
        universityCode: json["university_code"],
        expirationDate: json["expiration_date"] != null ? DateTime.parse(json["expiration_date"]) : null,
        fullName: json["full_name"],
        emergencyEmail: json["emergency_email"],
        creationDate: json["creation_date"] != null ? DateTime.parse(json["creation_date"]) : null,
        isActive: json["is_active"],
        emergencyPhone: json["emergency_phone"],
        phone: json["phone"],
        idTypeUser: json["id_type_user"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "document": document,
        "password": password,
        "email": email,
        "university_code": universityCode,
        "expiration_date": "${expirationDate!.year.toString().padLeft(4, '0')}-${expirationDate!.month.toString().padLeft(2, '0')}-${expirationDate!.day.toString().padLeft(2, '0')}",
        "full_name": fullName,
        "emergency_email": emergencyEmail,
        "creation_date": creationDate!.toIso8601String(),
        "is_active": isActive,
        "emergency_phone": emergencyPhone,
        "phone": phone,
        "id_type_user": idTypeUser,
    };
}

class Route {
    int id;
    String route;
    int idDeparture;
    int idArrival;
    Stop departure;
    Stop arrival;

    Route({
        required this.id,
        required this.route,
        required this.idDeparture,
        required this.idArrival,
        required this.departure,
        required this.arrival,
    });

    factory Route.fromJson(Map<String, dynamic> json) => Route(
        id: json["id"],
        route: json["route"],
        idDeparture: json["id_departure"],
        idArrival: json["id_arrival"],
        departure: Stop.fromJson(json["departure"]),
        arrival: Stop.fromJson(json["arrival"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "route": route,
        "id_departure": idDeparture,
        "id_arrival": idArrival,
        "departure": departure,
        "arrival": arrival
    };
}

class Unit {
    int id;
    String plate;
    String year;
    String description;
    Model model;

    Unit({
        required this.id,
        required this.plate,
        required this.year,
        required this.description,
        required this.model,
    });

    factory Unit.fromJson(Map<String, dynamic> json) => Unit(
        id: json["id"],
        plate: json["plate"],
        year: json["year"],
        description: json["description"],
        model: Model.fromJson(json["model"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "plate": plate,
        "year": year,
        "description": description,
        "model": model,
    };
}

class Model {
  int id;
  String model;
  Brand brand;

  Model({
      required this.id,
      required this.model,
      required this.brand,
  });

  factory Model.fromJson(Map<String, dynamic> json) => Model(
      id: json["id"],
      model: json["model"],
      brand: Brand.fromJson(json["brand"]),
  );

  Map<String, dynamic> toJson() => {
      "id": id,
      "model": model,
      "brand": brand.toJson(),
  };
}

class Brand {
  int id;
  String brand;

  Brand({
      required this.id,
      required this.brand,
  });

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
      id: json["id"],
      brand: json["brand"],
  );

  Map<String, dynamic> toJson() => {
      "id": id,
      "brand": brand,
  };
}