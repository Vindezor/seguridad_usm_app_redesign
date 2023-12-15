import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:test_design/ui/register/widgets/scanner_overlay.dart';

class RegisterQrScanner extends StatelessWidget {
  const RegisterQrScanner({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;


    return Scaffold(
      //appBar: AppBar(),
      body: MobileScanner(
        overlay: const QRScannerOverlay(overlayColour: Color.fromRGBO(0, 0, 0, 0.5),),
        scanWindow: Rect.fromCenter(center: Offset(width / 2, height / 2), width: 200, height: 200),
        onDetect: (capture) {
          final List<Barcode> barcodes = capture.barcodes;
          // final Uint8List? image = capture.image;
          for (final barcode in barcodes) {
            debugPrint('Barcode found! ${barcode.rawValue}');
          }
        },
      ),
    );
  }
}