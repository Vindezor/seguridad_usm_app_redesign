import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:test_design/app_config.dart';
import 'package:test_design/models/generic_model.dart';
import 'package:test_design/models/travel_model.dart';
import 'package:test_design/models/travels_model.dart';
import 'package:test_design/models/user_code_mode.dart';
import 'package:test_design/models/waiting_scan_model.dart';

class TravelService {
  final Dio _dio;
  CancelToken? cancelToken;

  TravelService(this._dio);

  Future<TravelModel?> findTravelById(id) async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: "token");
    try {
      final response = await _dio.post(
        '${AppConfig.instance.apiHost}findTravelById',
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

      final data = TravelModel.fromJson(response.data);
      return data;
    } catch (e) {
      log('[TravelService -> findTravelById] error: $e');
      return null;
    }
  }

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
      final response = await _dio.post(
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

  Future<TravelModel?> createTravel(String coordinate, int idRoute) async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: "token");
    try {
      final response = await _dio.post(
        '${AppConfig.instance.apiHost}createTravel',
        // 'http://172.16.90.115:8091/api/getAllConnectedParamedics',
        cancelToken: cancelToken,
        options: Options(
          contentType: "application/json",
          headers: {
            "Authorization": token,
          }
        ),
        data: {
          "coordinate": coordinate,
          "id_route": idRoute,
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

      final data = TravelModel.fromJson(response.data);
      return data;
    } catch (e) {
      log('[TravelService -> createTravel] error: $e');
      return null;
    }
  }

  Future<TravelModel?> endTravel() async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: "token");
    final idTravel = await storage.read(key: "id_travel");
    try {
      final response = await _dio.post(
        '${AppConfig.instance.apiHost}endTravel',
        // 'http://172.16.90.115:8091/api/getAllConnectedParamedics',
        cancelToken: cancelToken,
        options: Options(
          contentType: "application/json",
          headers: {
            "Authorization": token,
          }
        ),
        data: {
          "id_travel": idTravel,
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

      final data = TravelModel.fromJson(response.data);
      return data;
    } catch (e) {
      log('[TravelService -> endTravel] error: $e');
      return null;
    }
  }

  Future<TravelModel?> scanCode(code) async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: "token");
    final idTravel = await storage.read(key: "id_travel");
    try {
      final response = await _dio.post(
        '${AppConfig.instance.apiHost}scanCode',
        // 'http://172.16.90.115:8091/api/getAllConnectedParamedics',
        cancelToken: cancelToken,
        options: Options(
          contentType: "application/json",
          headers: {
            "Authorization": token,
          }
        ),
        data: {
          "id_travel": idTravel,
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

      final data = TravelModel.fromJson(response.data);
      return data;
    } catch (e) {
      log('[TravelService -> scanCode] error: $e');
      return null;
    }
  }

  Future<GenericModel?> emergency(coordinate) async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: "token");
    final idTravel = await storage.read(key: "id_travel");
    try {
      final response = await _dio.post(
        '${AppConfig.instance.apiHost}emergency',
        // 'http://172.16.90.115:8091/api/getAllConnectedParamedics',
        cancelToken: cancelToken,
        options: Options(
          contentType: "application/json",
          headers: {
            "Authorization": token,
          }
        ),
        data: {
          "id_travel": idTravel,
          "coordinate": coordinate,
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

      final data = GenericModel.fromJson(response.data);
      return data;
    } catch (e) {
      log('[TravelService -> emergency] error: $e');
      return null;
    }
  }

  Future<TravelsModel?> getAllTravelNotEnded() async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: "token");
    try {
      final response = await _dio.get(
        '${AppConfig.instance.apiHost}getAllTravelNotEnded',
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

      final data = TravelsModel.fromJson(response.data);
      return data;
    } catch (e) {
      log('[TravelService -> getAllTravelNotEnded] error: $e');
      return null;
    }
  }
}