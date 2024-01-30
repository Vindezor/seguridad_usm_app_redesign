// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
    String status;
    String msg;
    Data? data;

    LoginModel({
        required this.status,
        required this.msg,
        required this.data,
    });

    factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        status: json["status"],
        msg: json["msg"],
        data: json["data"] != null ? Data.fromJson(json["data"]) : null,
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
        "data": data != null ? data?.toJson() : null,
    };
}

class Data {
    String token;
    User user;

    Data({
        required this.token,
        required this.user,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        token: json["token"],
        user: User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "token": token,
        "user": user.toJson(),
    };
}

class User {
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
    TypeUser typeUser;

    User({
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
        required this.typeUser,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        document: json["document"],
        password: json["password"],
        email: json["email"],
        universityCode: json["university_code"],
        expirationDate: json["expiration_date"] != null ? DateTime.parse(json["expiration_date"]).toLocal() : null,
        fullName: json["full_name"],
        emergencyEmail: json["emergency_email"],
        creationDate: DateTime.parse(json["creation_date"]).toLocal(),
        isActive: json["is_active"],
        emergencyPhone: json["emergency_phone"],
        phone: json["phone"],
        typeUser: TypeUser.fromJson(json["type_user"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "document": document,
        "password": password,
        "email": email,
        "university_code": universityCode,
        "expiration_date": expirationDate == null ? null : "${expirationDate!.year.toString().padLeft(4, '0')}-${expirationDate!.month.toString().padLeft(2, '0')}-${expirationDate!.day.toString().padLeft(2, '0')}",
        "full_name": fullName,
        "emergency_email": emergencyEmail,
        "creation_date": creationDate!.toIso8601String(),
        "is_active": isActive,
        "emergency_phone": emergencyPhone,
        "phone": phone,
        "type_user": typeUser.toJson(),
    };
}

class TypeUser {
    int id;
    String typeUser;

    TypeUser({
        required this.id,
        required this.typeUser,
    });

    factory TypeUser.fromJson(Map<String, dynamic> json) => TypeUser(
        id: json["id"],
        typeUser: json["type_user"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "type_user": typeUser,
    };
}
