// ignore_for_file: library_prefixes

import 'dart:async';
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
import 'package:test_design/ui/home/widgets/qr_timer.dart';

class HomeController extends ChangeNotifier{
  
  FlutterSecureStorage storage = const FlutterSecureStorage();
  TravelService travelService = TravelService(Dio());
  int? idTypeUser;
  Timer? timeTimer;
  Duration? currentDuration;

  HomeController(){
    log("[HomeController] init");
  }

  initProfile() async {
    idTypeUser = int.parse((await storage.read(key: 'id_type_user'))!);
    notifyListeners();
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

  homeButton(context) async {
    final idTypeUser = int.parse((await storage.read(key: 'id_type_user'))!);
    if(idTypeUser == 1) showQr(context);
    if(idTypeUser == 2) Navigator.pushNamed(context, '/start_route');
    if(idTypeUser == 3 || idTypeUser == 4) Navigator.pushNamed(context, '/admin_map');
  }

  showQr(context) async {
    globalLoading(context);
    final response = await travelService.generateUserCode();
    if(response != null){
      if(response.status == "SUCCESS"){
        currentDuration = const Duration(seconds: 60);
        timeTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
          currentDuration = Duration(seconds: currentDuration!.inSeconds - 1);
          notifyListeners();
        });
        Navigator.of(context).pop();
        log(response.data!.code);
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => PopScope(
            canPop: false,
            child: Dialog(
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
                      textAlign: TextAlign.center,
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
                    const QrTimer()
                  ],
                ),
              ),
            ),
          ),
        ).then((value) => timeTimer!.cancel());
        final waitResponse = await travelService.waitForScan(response.data!.code);
        if(waitResponse != null){
          if(waitResponse.status == "SUCCESS"){
            storage.write(key: 'id_travel', value: waitResponse.data!.idTravel);
            Navigator.of(context).pop();
            Navigator.of(context).pushNamed('/map');
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

  String formatDuration(Duration duration) {
  // Obtén los minutos y segundos de la duración
    int minutes = duration.inMinutes;
    int seconds = duration.inSeconds % 60;

    // Formatea la cadena
    String formattedDuration = '$minutes:${seconds.toString().padLeft(2, '0')}';

    return formattedDuration;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    log("[HomeController] disposed");
  }
}

final homeController = ChangeNotifierProvider.autoDispose<HomeController>((_) => HomeController());