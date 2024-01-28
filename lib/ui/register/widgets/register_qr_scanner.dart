import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:test_design/global/scanner_overlay.dart';
import 'package:test_design/ui/register/widgets/register_qr_controller.dart';

class RegisterQrScanner extends ConsumerWidget {
  const RegisterQrScanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(registerQrController);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if(!controller.isInitialized){
        controller.init();
      }
    });


    return Scaffold(
      //appBar: AppBar(),
      body: MobileScanner(
        controller: controller.scannerController,
        overlay: const QRScannerOverlay(overlayColour: Color.fromRGBO(0, 0, 0, 0.5),),
        scanWindow: Rect.fromCenter(center: Offset(width / 2, height / 2), width: 200, height: 200),
        onDetect: (capture) {
          controller.onCapture(capture, context);
        },
      ),
    );
  }
}