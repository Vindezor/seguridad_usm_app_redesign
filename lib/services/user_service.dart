// ignore_for_file: non_constant_identifier_names

import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:test_design/app_config.dart';
import 'package:test_design/models/generic_model.dart';
import 'package:test_design/models/login_model.dart';
import 'package:test_design/models/update_user_model.dart';
import 'package:test_design/models/user_model.dart';
import 'package:test_design/models/users_mode.dart';

class UserService {
  final Dio _dio;
  CancelToken? cancelToken;

  UserService(this._dio);

  Future<GenericModel?> register({required String university_code}) async {
    try {
      final response = await _dio.post(
        '${AppConfig.instance.apiHost}register',
        // 'http://172.16.90.115:8091/api/getAllConnectedParamedics',
        cancelToken: cancelToken,
        data: {
          "university_code": university_code,
        },
        options: Options(
          contentType: "application/json",
        ),
        // options: Options(
        //   headers: {
        //     'Content-Type': 'application/json',
        //     'platform': 'EXT',
        //     'BISCOMM_KEY': 'abcd123456',
        //     'token': token
        //   }
        // )
      );

      final data = GenericModel.fromJson(response.data);
      return data;
    } catch (e) {
      log('[UserService -> register] error: $e');
      return null;
    }
  }

  Future<LoginModel?> login({required String document, required String password}) async {
    try {
      final response = await _dio.post(
        '${AppConfig.instance.apiHost}login',
        // 'http://172.16.90.115:8091/api/getAllConnectedParamedics',
        cancelToken: cancelToken,
        data: {
          "document": document,
          "password": password,
        },
        options: Options(
          contentType: "application/json",
        ),
        // options: Options(
        //   headers: {
        //     'Content-Type': 'application/json',
        //     'platform': 'EXT',
        //     'BISCOMM_KEY': 'abcd123456',
        //     'token': token
        //   }
        // )
      );

      final data = LoginModel.fromJson(response.data);
      return data;
    } catch (e) {
      log('[UserService -> login] error: $e');
      return null;
    }
  }

  Future<UpdateUserModel?> updateUser({int? id_user, String? phone, String? emergency_phone, String? emergency_email, String? password}) async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: "token");
    try {
      final response = await _dio.post(
        '${AppConfig.instance.apiHost}updateUser',
        // 'http://172.16.90.115:8091/api/getAllConnectedParamedics',
        cancelToken: cancelToken,
        data: {
          "id_user": id_user,
          "phone": phone,
          "emergency_phone": emergency_phone,
          "emergency_email": emergency_email,
          "password": password,
        },
        options: Options(
          contentType: "application/json",
          headers: {
            "Authorization": token,
          }
        ),
        // options: Options(
        //   headers: {
        //     'Content-Type': 'application/json',
        //     'platform': 'EXT',
        //     'BISCOMM_KEY': 'abcd123456',
        //     'token': token
        //   }
        // )
      );

      final data = UpdateUserModel.fromJson(response.data);
      return data;
    } catch (e) {
      log('[UserService -> updateUser] error: $e');
      return null;
    }
  }

  Future<UsersModel?> getAllDrivers() async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: "token");
    try {
      final response = await _dio.get(
        '${AppConfig.instance.apiHost}getAllDrivers',
        // 'http://172.16.90.115:8091/api/getAllConnectedParamedics',
        cancelToken: cancelToken,
        options: Options(
          contentType: "application/json",
          headers: {
            "Authorization": token,
          }
        ),
        // options: Options(
        //   headers: {
        //     'Content-Type': 'application/json',
        //     'platform': 'EXT',
        //     'BISCOMM_KEY': 'abcd123456',
        //     'token': token
        //   }
        // )
      );

      final data = UsersModel.fromJson(response.data);
      return data;
    } catch (e) {
      log('[UserService -> getAllDrivers] error: $e');
      return null;
    }
  }

  Future<UsersModel?> getAllAdmins() async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: "token");
    try {
      final response = await _dio.get(
        '${AppConfig.instance.apiHost}getAllAdmins',
        // 'http://172.16.90.115:8091/api/getAllConnectedParamedics',
        cancelToken: cancelToken,
        options: Options(
          contentType: "application/json",
          headers: {
            "Authorization": token,
          }
        ),
        // options: Options(
        //   headers: {
        //     'Content-Type': 'application/json',
        //     'platform': 'EXT',
        //     'BISCOMM_KEY': 'abcd123456',
        //     'token': token
        //   }
        // )
      );

      final data = UsersModel.fromJson(response.data);
      return data;
    } catch (e) {
      log('[UserService -> getAllAdmins] error: $e');
      return null;
    }
  }

  Future<UsersModel?> deleteDriver(id) async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: "token");
    try {
      final response = await _dio.post(
        '${AppConfig.instance.apiHost}deleteDriver',
        // 'http://172.16.90.115:8091/api/getAllConnectedParamedics',
        cancelToken: cancelToken,
        options: Options(
          contentType: "application/json",
          headers: {
            "Authorization": token,
          }
        ),
        data: {
          "id": id,
        }
        // options: Options(
        //   headers: {
        //     'Content-Type': 'application/json',
        //     'platform': 'EXT',
        //     'BISCOMM_KEY': 'abcd123456',
        //     'token': token
        //   }
        // )
      );

      final data = UsersModel.fromJson(response.data);
      return data;
    } catch (e) {
      log('[UserService -> deleteDriver] error: $e');
      return null;
    }
  }

  Future<UsersModel?> deleteAdmin(id) async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: "token");
    try {
      final response = await _dio.post(
        '${AppConfig.instance.apiHost}deleteAdmin',
        // 'http://172.16.90.115:8091/api/getAllConnectedParamedics',
        cancelToken: cancelToken,
        options: Options(
          contentType: "application/json",
          headers: {
            "Authorization": token,
          }
        ),
        data: {
          "id": id,
        }
        // options: Options(
        //   headers: {
        //     'Content-Type': 'application/json',
        //     'platform': 'EXT',
        //     'BISCOMM_KEY': 'abcd123456',
        //     'token': token
        //   }
        // )
      );

      final data = UsersModel.fromJson(response.data);
      return data;
    } catch (e) {
      log('[UserService -> deleteAdmin] error: $e');
      return null;
    }
  }

  Future<UserModel?> updateDriver({int? id, String? fullName, String? document, String? phone, String? email, String? password}) async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: "token");
    try {
      final response = await _dio.post(
        '${AppConfig.instance.apiHost}updateDriver',
        // 'http://172.16.90.115:8091/api/getAllConnectedParamedics',
        cancelToken: cancelToken,
        options: Options(
          contentType: "application/json",
          headers: {
            "Authorization": token,
          }
        ),
        data: {
          "id": id,
          "full_name": fullName,
          "document": document,
          "phone": phone,
          "email": email,
          "password": password,
        },
        // options: Options(
        //   headers: {
        //     'Content-Type': 'application/json',
        //     'platform': 'EXT',
        //     'BISCOMM_KEY': 'abcd123456',
        //     'token': token
        //   }
        // )
      );

      final data = UserModel.fromJson(response.data);
      return data;
    } catch (e) {
      log('[UserService -> updateDriver] error: $e');
      return null;
    }
  }

  Future<UserModel?> updateAdmin({int? id, String? fullName, String? document, String? phone, String? email, String? password}) async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: "token");
    try {
      final response = await _dio.post(
        '${AppConfig.instance.apiHost}updateAdmin',
        // 'http://172.16.90.115:8091/api/getAllConnectedParamedics',
        cancelToken: cancelToken,
        options: Options(
          contentType: "application/json",
          headers: {
            "Authorization": token,
          }
        ),
        data: {
          "id": id,
          "full_name": fullName,
          "document": document,
          "phone": phone,
          "email": email,
          "password": password,
        },
        // options: Options(
        //   headers: {
        //     'Content-Type': 'application/json',
        //     'platform': 'EXT',
        //     'BISCOMM_KEY': 'abcd123456',
        //     'token': token
        //   }
        // )
      );

      final data = UserModel.fromJson(response.data);
      return data;
    } catch (e) {
      log('[UserService -> updateAdmin] error: $e');
      return null;
    }
  }

  Future<UserModel?> createDriver({int? id_user, String? fullName, String? document, String? phone, String? email, String? password}) async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: "token");
    try {
      final response = await _dio.post(
        '${AppConfig.instance.apiHost}createDriver',
        // 'http://172.16.90.115:8091/api/getAllConnectedParamedics',
        cancelToken: cancelToken,
        options: Options(
          contentType: "application/json",
          headers: {
            "Authorization": token,
          }
        ),
        data: {
          "id_user": id_user,
          "full_name": fullName,
          "document": document,
          "phone": phone,
          "email": email,
          "password": password,
        },
        // options: Options(
        //   headers: {
        //     'Content-Type': 'application/json',
        //     'platform': 'EXT',
        //     'BISCOMM_KEY': 'abcd123456',
        //     'token': token
        //   }
        // )
      );

      final data = UserModel.fromJson(response.data);
      return data;
    } catch (e) {
      log('[UserService -> createDriver] error: $e');
      return null;
    }
  }

  Future<UserModel?> createAdmin({int? id_user, String? fullName, String? document, String? phone, String? email, String? password}) async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: "token");
    try {
      final response = await _dio.post(
        '${AppConfig.instance.apiHost}createAdmin',
        // 'http://172.16.90.115:8091/api/getAllConnectedParamedics',
        cancelToken: cancelToken,
        options: Options(
          contentType: "application/json",
          headers: {
            "Authorization": token,
          }
        ),
        data: {
          "id_user": id_user,
          "full_name": fullName,
          "document": document,
          "phone": phone,
          "email": email,
          "password": password,
        },
        // options: Options(
        //   headers: {
        //     'Content-Type': 'application/json',
        //     'platform': 'EXT',
        //     'BISCOMM_KEY': 'abcd123456',
        //     'token': token
        //   }
        // )
      );

      final data = UserModel.fromJson(response.data);
      return data;
    } catch (e) {
      log('[UserService -> createAdmin] error: $e');
      return null;
    }
  }

}