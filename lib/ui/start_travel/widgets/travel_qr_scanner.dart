import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:test_design/global/scanner_overlay.dart';
import 'package:test_design/ui/start_travel/widgets/travel_qr_controller.dart';


class TravelQrScanner extends ConsumerWidget {

  const TravelQrScanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final controller = ref.watch(travelQrController);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if(controller.buttonText == ""){
        controller.checkForMore();
      }
    });

    return PopScope(
      canPop: false,
      child: Scaffold(
        //appBar: AppBar(),
        body: MobileScanner(
          controller: controller.qrController,
          overlay: const QRScannerOverlay(overlayColour: Color.fromRGBO(0, 0, 0, 0.5),),
          scanWindow: Rect.fromCenter(center: Offset(width / 2, height / 2), width: 200, height: 200),
          onDetect: (capture) => controller.onCapture(capture, context),
        ),
        extendBody: true,
        bottomNavigationBar: BottomAppBar(
          surfaceTintColor: Colors.transparent,
          color: Colors.transparent,
          child: Center(
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFFe9f2f7)),
              ),
              onPressed: () => controller.startRoute(context),
              child: Text(
                controller.buttonText,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          
        ),
      ),
    );
  }
}