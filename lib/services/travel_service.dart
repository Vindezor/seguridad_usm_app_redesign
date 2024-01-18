import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:test_design/app_config.dart';
import 'package:test_design/models/user_code_mode.dart';
import 'package:test_design/models/waiting_scan_model.dart';

class TravelService {
  final Dio _dio;
  CancelToken? cancelToken;

  TravelService(this._dio);

  Future<UserCodeModel?> generateUserCode() async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: "token");
    try {
      final response = await _dio.get(
        '${AppConfig.instance.apiHost}generateUserCode',
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

      final data = UserCodeModel.fromJson(response.data);
      return data;
    } catch (e) {
      log('[TravelService -> generateUserCode] error: $e');
      return null;
    }
  }

  Future<WaitingScanModel?> waitForScan(code) async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: "token");
    try {
      final response = await _dio.get(
        '${AppConfig.instance.apiHost}waitForScan',
        // 'http://172.16.90.115:8091/api/getAllConnectedParamedics',
        cancelToken: cancelToken,
        options: Options(
          contentType: "application/json",
          headers: {
            "Authorization": token,
          }
        ),
        data: {
          "code": code,
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

      final data = WaitingScanModel.fromJson(response.data);
      return data;
    } catch (e) {
      log('[TravelService -> waitForScan] error: $e');
      return null;
    }
  }
}