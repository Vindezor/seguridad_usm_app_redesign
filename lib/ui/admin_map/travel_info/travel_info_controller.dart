import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:test_design/global/global_dialog.dart';
import 'package:test_design/global/global_loading.dart';
import 'package:test_design/services/travel_service.dart';

class TravelInfoController extends ChangeNotifier{
  FlutterSecureStorage storage = const FlutterSecureStorage();
  TravelService travelService = TravelService(Dio());
  int? idTypeUser;

  TravelInfoController(){
    log("[TravelInfoController] init");
  }

  init() async {
    idTypeUser = int.parse((await storage.read(key: 'id_type_user'))!);
    notifyListeners();
  }

  endTravel(context, idTravel){
    showAlertOptions(
      context,
      msg: '¿Seguro que desea finalizar el viaje?',
      title: 'Importante',
      acceptOnPressed: () async {
        Navigator.of(context).pop();
        globalLoading(context);
        final response = await travelService.endTravel(idTravel);
        if(response != null) {
          Navigator.of(context).pop();
          if(response.status == "SUCCESS"){
            showAlertOptions(
              context,
              msg: response.msg!,
              title: "Importante",
              closeOnPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop('ended');
              },
            );
          } else {
            showAlertOptions(
              context,
              msg: response.msg!,
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
      },
    );
  }

  goToAllPassengers(context, idTravel){
    Navigator.of(context).pushNamed('/travel_passengers', arguments: {
      "id_travel": idTravel,
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    log("[TravelInfoController] disposed");
  }
}

final travelInfoController = ChangeNotifierProvider.autoDispose((_) => TravelInfoController());