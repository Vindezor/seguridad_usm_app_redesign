import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class RegisterQrController extends ChangeNotifier{
  
  RegisterQrController(){
    log("[RegisterQrController] init");
  }
  
  final regex = RegExp(r'^https:\/\/usm\.terna\.net\/validar\/[a-zA-Z0-9]{7}$');
  bool isDetect = false;
  bool isInitialized = false;
  final scannerController = MobileScannerController(autoStart: false);

  init(){
    isInitialized = true;
    scannerController.start();
  }

  onCapture(capture, context){
    final List<Barcode> barcodes = capture.barcodes;
    // final Uint8List? image = capture.image;
    for (final barcode in barcodes) {
      if(barcode.rawValue != null){
        if(regex.hasMatch(barcode.rawValue!) && !isDetect) {
          isDetect = true;
          final linkSplited = barcode.rawValue!.split('/');
          Navigator.of(context).pop(linkSplited[linkSplited.length - 1]);
        }
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    scannerController.dispose();
    log("[RegisterQrController] disposed");
  }
}

final registerQrController = ChangeNotifierProvider.autoDispose<RegisterQrController>((_) => RegisterQrController());