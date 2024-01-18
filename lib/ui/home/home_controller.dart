// ignore_for_file: library_prefixes

import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:test_design/global/global_dialog.dart';
import 'package:test_design/global/global_loading.dart';
import 'package:test_design/routes/routes.dart';
import 'package:test_design/services/travel_service.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class HomeController extends ChangeNotifier{
  
  FlutterSecureStorage storage = const FlutterSecureStorage();
  TravelService travelService = TravelService(Dio());
  IO.Socket socket = IO.io('http://10.0.2.2:3000/test',
    IO.OptionBuilder()
      .disableAutoConnect()
      .setTransports(['websocket'])
      .build()
  );
  
  HomeController(){
    log("[HomeController] init");
    socket.on('connect', (_) {
      log('connect');
    });
    socket.onError((data) => log("$data"));
    socket.on('event', (data) => log(data));
    socket.onDisconnect((_) => log('disconnect'));
    socket.on('fromServer', (_) => log(_));
  }

  logout(context) {
    showAlertOptions(
      context,
      msg: "¿Esta seguro/a que desea cerrar sesión?",
      title: "Importante",
      acceptOnPressed: () async {
        await storage.deleteAll();
        Navigator.of(context).pop();
        Navigator.of(context).pushReplacementNamed(Routes.login);
      },
      justified: true
    );
  }

  connectSocket(){
    socket.connect();
    //log("Conectado");
  }

  disconnectSocket(){
    socket.disconnect();
    //socket.clearListeners();
  }

  sendSocket(){
    socket.emit('msg', 'Hola Mundo');
  }

  showQr(context) async {
    globalLoading(context);
    final response = await travelService.generateUserCode();
    if(response != null){
      if(response.status == "SUCCESS"){
        Navigator.of(context).pop();
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => Dialog(
            surfaceTintColor: Colors.white,
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "QR para inciar ruta",
                    style: TextStyle(
                      color: Color(0xFF3874c0),
                      fontSize: 26,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  QrImageView(
                    data: response.data!.code,
                    size: 200,
                    dataModuleStyle: const QrDataModuleStyle(dataModuleShape: QrDataModuleShape.square, color: Color(0xFF3874c0)),
                    eyeStyle: const QrEyeStyle(eyeShape: QrEyeShape.square, color: Color(0xFF3874c0)),
                  ),
                  const Text("5:00")
                ],
              ),
            ),
          ),
        );
        final waitResponse = await travelService.waitForScan(response.data!.code);
        if(waitResponse != null){
          if(waitResponse.status == "SUCCESS"){
            storage.write(key: 'id_travel', value: waitResponse.data!.idTravel);
            Navigator.of(context).pop();
            Navigator.of(context).pushReplacementNamed('/map');
          } else {
            Navigator.of(context).pop();
            showAlertOptions(
              context,
              msg: waitResponse.msg,
              title: "Importante"
            );
          }
        } else {
          Navigator.of(context).pop();
          showAlertOptions(
            context,
            msg: "Ha ocurrido un error con el servicio. Intente mas tarde",
            title: "Importante"
          );
        }
      } else {
        Navigator.of(context).pop();
        showAlertOptions(
          context,
          msg: response.msg,
          title: "Importante"
        );
      }
    } else {
      Navigator.of(context).pop();
      showAlertOptions(
        context,
        msg: "Ha ocurrido un error con el servicio. Intente mas tarde",
        title: "Importante"
      );
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    socket.dispose();
    log("[HomeController] disposed");
  }
}

final homeController = ChangeNotifierProvider.autoDispose<HomeController>((_) => HomeController());