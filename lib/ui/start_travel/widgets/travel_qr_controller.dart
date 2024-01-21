import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:test_design/global/global_dialog.dart';
import 'package:test_design/global/global_loading.dart';
import 'package:test_design/services/travel_service.dart';

class TravelQrController extends ChangeNotifier{

  final qrController = MobileScannerController();
  bool isDetect = false;
  final regex = RegExp(r'^[0-9a-fA-F]{8}\b-[0-9a-fA-F]{4}\b-[0-9a-fA-F]{4}\b-[0-9a-fA-F]{4}\b-[0-9a-fA-F]{12}$');
  final TravelService travelService = TravelService(Dio());
  final storage = const FlutterSecureStorage();
  String buttonText = "";
  bool scanningMore = false;
  TravelQrController(){
    log("[TravelQrController] init");
  }

  //int value;

  //final UserService userService = UserService(Dio());

  void onCapture(capture, context) async {
    final List<Barcode> barcodes = capture.barcodes;
    // final Uint8List? image = capture.image;
    for (final barcode in barcodes) {
      if(barcode.rawValue != null){
        log("${barcode.rawValue}");
        if(regex.hasMatch(barcode.rawValue!) && !isDetect) {
          isDetect = true;
          await scanCode(barcode.rawValue!, context);
        }
      }
    }
  }

  void checkForMore() async {
    final scanningMoreCheck = await storage.read(key: 'scanning_more');
    if(scanningMoreCheck != null && scanningMoreCheck == 'true'){
      buttonText = 'Regresar al viaje';
      scanningMore = true;
    } else {
      buttonText = 'Ir al viaje';
    }
    notifyListeners();
  }

  void startRoute(context){
    if(scanningMore){
      Navigator.of(context).pop();
    } else {
      Navigator.of(context).pushReplacementNamed('/map');
    }
  }

  Future<void> scanCode(code, context) async {
    globalLoading(context);
    final response = await travelService.scanCode(code);
    if(response != null) {
      Navigator.of(context).pop();
      if(response.status == "SUCCESS"){
        showAlertOptions(
          context,
          msg: response.msg!,
          title: "Importante",
          closeOnPressed: () {
            Navigator.of(context).pop();
            isDetect = false;
          },
        );
      } else {
        showAlertOptions(
          context,
          msg: response.msg!,
          title: "Importante",
          closeOnPressed: () {
            Navigator.of(context).pop();
            isDetect = false;
          },
        );
      }
    } else {
      Navigator.of(context).pop();
      showAlertOptions(
        context,
        msg: "Ha ocurrido un error con el servicio. Intente mas tarde",
        title: "Importante",
        closeOnPressed: () {
          Navigator.of(context).pop();
          isDetect = false;
        },
      );
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    qrController.stop();
    qrController.dispose();
    log("[TravelQrController] disposed");
  }
}

final travelQrController = ChangeNotifierProvider.autoDispose((_) => TravelQrController());