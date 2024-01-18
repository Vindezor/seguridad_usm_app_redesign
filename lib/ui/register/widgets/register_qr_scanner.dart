import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:test_design/ui/register/widgets/scanner_overlay.dart';

class RegisterQrScanner extends StatefulWidget {

  const RegisterQrScanner({super.key});

  @override
  State<RegisterQrScanner> createState() => _RegisterQrScannerState();
}

class _RegisterQrScannerState extends State<RegisterQrScanner> {
  final regex = RegExp(r'^https:\/\/usm\.terna\.net\/validar\/[a-zA-Z0-9]{7}$');
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
                final linkSplited = barcode.rawValue!.split('/');
                Navigator.of(context).pop(linkSplited[linkSplited.length - 1]);
              }
            }
          }
        },
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