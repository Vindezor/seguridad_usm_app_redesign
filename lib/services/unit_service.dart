import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:test_design/app_config.dart';
import 'package:test_design/models/brands_model.dart';
import 'package:test_design/models/models_model.dart';
import 'package:test_design/models/units_model.dart';

class UnitService {
  final Dio _dio;
  CancelToken? cancelToken;

  UnitService(this._dio);

  Future<UnitsModel?> getAllUnits() async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: "token");
    try {
      final response = await _dio.get(
        '${AppConfig.instance.apiHost}getAllUnits',
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

      final data = UnitsModel.fromJson(response.data);
      return data;
    } catch (e) {
      log('[UnitService -> getAllUnits] error: $e');
      return null;
    }
  }

  Future<BrandsModel?> getAllBrands() async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: "token");
    try {
      final response = await _dio.get(
        '${AppConfig.instance.apiHost}getAllBrands',
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

      final data = BrandsModel.fromJson(response.data);
      return data;
    } catch (e) {
      log('[UnitService -> getAllBrands] error: $e');
      return null;
    }
  }

  Future<ModelsModel?> getAllModels() async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: "token");
    try {
      final response = await _dio.get(
        '${AppConfig.instance.apiHost}getAllModels',
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

      final data = ModelsModel.fromJson(response.data);
      return data;
    } catch (e) {
      log('[UnitService -> getAllModels] error: $e');
      return null;
    }
  }

  Future<ModelsModel?> getAllModelsByIdBrand(idBrand) async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: "token");
    try {
      final response = await _dio.post(
        '${AppConfig.instance.apiHost}getAllModelsByIdBrand',
        // 'http://172.16.90.115:8091/api/getAllConnectedParamedics',
        cancelToken: cancelToken,
        options: Options(
          contentType: "application/json",
          headers: {
            "Authorization": token,
          }
        ),
        data: {
          "id_brand": idBrand
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

      final data = ModelsModel.fromJson(response.data);
      return data;
    } catch (e) {
      log('[UnitService -> getAllModelsByIdBrand] error: $e');
      return null;
    }
  }

  Future<UnitsModel?> createUnit({String? plate, String? year, String? description, int? idDriver, int? idModel}) async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: "token");
    try {
      final response = await _dio.post(
        '${AppConfig.instance.apiHost}createUnit',
        // 'http://172.16.90.115:8091/api/getAllConnectedParamedics',
        cancelToken: cancelToken,
        options: Options(
          contentType: "application/json",
          headers: {
            "Authorization": token,
          }
        ),
        data: {
          "plate": plate,
          "year": year,
          "description": description,
          "id_driver": idDriver,
          "id_model": idModel,
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

      final data = UnitsModel.fromJson(response.data);
      return data;
    } catch (e) {
      log('[UnitService -> createUnit] error: $e');
      return null;
    }
  }

  Future<UnitsModel?> createBrand({String? brand}) async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: "token");
    try {
      final response = await _dio.post(
        '${AppConfig.instance.apiHost}createBrand',
        // 'http://172.16.90.115:8091/api/getAllConnectedParamedics',
        cancelToken: cancelToken,
        options: Options(
          contentType: "application/json",
          headers: {
            "Authorization": token,
          }
        ),
        data: {
          "brand": brand,
          
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

      final data = UnitsModel.fromJson(response.data);
      return data;
    } catch (e) {
      log('[UnitService -> createBrand] error: $e');
      return null;
    }
  }

  Future<UnitsModel?> createModel({String? model, int? idBrand}) async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: "token");
    try {
      final response = await _dio.post(
        '${AppConfig.instance.apiHost}createModel',
        // 'http://172.16.90.115:8091/api/getAllConnectedParamedics',
        cancelToken: cancelToken,
        options: Options(
          contentType: "application/json",
          headers: {
            "Authorization": token,
          }
        ),
        data: {
          "model": model,
          "id_brand": idBrand,
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

      final data = UnitsModel.fromJson(response.data);
      return data;
    } catch (e) {
      log('[UnitService -> createModel] error: $e');
      return null;
    }
  }

  Future<UnitsModel?> updateUnit({int? id, String? plate, String? year, String? description, int? idDriver, int? idModel}) async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: "token");
    try {
      final response = await _dio.post(
        '${AppConfig.instance.apiHost}updateUnit',
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
          "plate": plate,
          "year": year,
          "description": description,
          "id_driver": idDriver,
          "id_model": idModel,
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

      final data = UnitsModel.fromJson(response.data);
      return data;
    } catch (e) {
      log('[UnitService -> updateUnit] error: $e');
      return null;
    }
  }

  Future<UnitsModel?> updateBrand({int? id, String? brand}) async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: "token");
    try {
      final response = await _dio.post(
        '${AppConfig.instance.apiHost}updateBrand',
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
          "brand": brand,
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

      final data = UnitsModel.fromJson(response.data);
      return data;
    } catch (e) {
      log('[UnitService -> updateBrand] error: $e');
      return null;
    }
  }

  Future<UnitsModel?> updateModel({int? id, String? model, int? idBrand}) async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: "token");
    try {
      final response = await _dio.post(
        '${AppConfig.instance.apiHost}updateModel',
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
          "model": model,
          "id_brand": idBrand,
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

      final data = UnitsModel.fromJson(response.data);
      return data;
    } catch (e) {
      log('[UnitService -> updateModel] error: $e');
      return null;
    }
  }

  Future<UnitsModel?> deleteUnit(id) async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: "token");
    try {
      final response = await _dio.post(
        '${AppConfig.instance.apiHost}deleteUnit',
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

      final data = UnitsModel.fromJson(response.data);
      return data;
    } catch (e) {
      log('[UnitService -> deleteUnit] error: $e');
      return null;
    }
  }

  Future<UnitsModel?> deleteBrand(id) async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: "token");
    try {
      final response = await _dio.post(
        '${AppConfig.instance.apiHost}deleteBrand',
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

      final data = UnitsModel.fromJson(response.data);
      return data;
    } catch (e) {
      log('[UnitService -> deleteBrand] error: $e');
      return null;
    }
  }

  Future<UnitsModel?> deleteModel(id) async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: "token");
    try {
      final response = await _dio.post(
        '${AppConfig.instance.apiHost}deleteModel',
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

      final data = UnitsModel.fromJson(response.data);
      return data;
    } catch (e) {
      log('[UnitService -> deleteModel] error: $e');
      return null;
    }
  }
}