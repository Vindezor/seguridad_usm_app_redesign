import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:test_design/app_config.dart';
import 'package:test_design/models/here_route_model.dart';
import 'package:test_design/models/routes_model.dart';

class RouteService {
  final Dio _dio;
  CancelToken? cancelToken;

  RouteService(this._dio);

  Future<RoutesModel?> getAllRoutes() async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: "token");
    try {
      final response = await _dio.get(
        '${AppConfig.instance.apiHost}getAllRoutes',
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

      final data = RoutesModel.fromJson(response.data);
      return data;
    } catch (e) {
      log('[RouteService -> getAllRoutes] error: $e');
      return null;
    }
  }

  Future<RoutesModel?> deleteRoute(id) async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: "token");
    try {
      final response = await _dio.post(
        '${AppConfig.instance.apiHost}deleteRoute',
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

      final data = RoutesModel.fromJson(response.data);
      return data;
    } catch (e) {
      log('[RouteService -> deleteRoute] error: $e');
      return null;
    }
  }

  Future<HereRouteModel?> getRouteBetweenPoints({
    required LatLng origin,
    required LatLng destination,
  }) async {
    try {
      final response = await _dio.get(AppConfig.instance.hereApiHost, queryParameters: {
        'apiKey': AppConfig.instance.hereApiKey,
        "origin": "${origin.latitude},${origin.longitude}",
        "destination": "${destination.latitude},${destination.longitude}",
        "transportMode": "car",
        "return": "polyline,summary",
        "alternatives": 1,
        "lang": "es"
      });

      return HereRouteModel.fromJson(response.data);
    } catch (e) {
      log("[RouteService -> getRouteBetweenPoints] error: $e");
      return null;
    }
  }
}