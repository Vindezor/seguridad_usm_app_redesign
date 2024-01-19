import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:test_design/global/scanner_overlay.dart';

class TravelQrScanner extends StatefulWidget {

  const TravelQrScanner({super.key});

  @override
  State<TravelQrScanner> createState() => _TravelQrScannerState();
}

class _TravelQrScannerState extends State<TravelQrScanner> {
  final regex = RegExp(r'^[0-9a-fA-F]{8}\b-[0-9a-fA-F]{4}\b-[0-9a-fA-F]{4}\b-[0-9a-fA-F]{4}\b-[0-9a-fA-F]{12}$');
  bool isDetect = false;
  final controller = MobileScannerController();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;


    return Scaffold(
      //appBar: AppBar(),
      body: MobileScanner(
        controller: controller,
        overlay: const QRScannerOverlay(overlayColour: Color.fromRGBO(0, 0, 0, 0.5),),
        scanWindow: Rect.fromCenter(center: Offset(width / 2, height / 2), width: 200, height: 200),
        onDetect: (capture) {
          final List<Barcode> barcodes = capture.barcodes;
          // final Uint8List? image = capture.image;
          for (final barcode in barcodes) {
            if(barcode.rawValue != null){
              if(regex.hasMatch(barcode.rawValue!) && !isDetect) {
                isDetect = true;
                //Navigator.of(context).pop(barcode.rawValue!);
              }
            }
          }
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Center(
          child: TextButton(child: const Text("Comenzar Ruta"), onPressed: () => {},)
        ),
        
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.stop();
    controller.dispose();
  }
}