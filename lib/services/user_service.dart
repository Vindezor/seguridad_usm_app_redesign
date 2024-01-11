import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:test_design/app_config.dart';
import 'package:test_design/models/generic_model.dart';
import 'package:test_design/models/login_model.dart';

class UserService {
  final Dio _dio;
  CancelToken? cancelToken;

  UserService(this._dio);

  // ignore: non_constant_identifier_names
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
      log('[UserService -> register] error: $e');
      return null;
    }
  }

}