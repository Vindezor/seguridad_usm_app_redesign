import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_design/global/global_dialog.dart';
import 'package:test_design/global/global_loading.dart';
import 'package:test_design/models/stops_model.dart';
import 'package:test_design/services/stop_service.dart';

class AdministrateStopsController extends ChangeNotifier{

  final StopService stopService = StopService(Dio());
  List<Stop>? stops;

  AdministrateStopsController();

  getAllStops(context) async {
    globalLoading(context);
    final response = await stopService.getAllStop();
    if(response != null){
      if(response.status == "SUCCESS"){
        stops = response.data;
        notifyListeners();
        Navigator.of(context).pop();
      } else {
        Navigator.of(context).pop();
        showAlertOptions(
          context,
          msg: response.msg!,
          title: "Importante",
          closeOnPressed: () {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          }
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
          Navigator.of(context).pop();
        }
      );
    }
  }

  deleteStop(context, id){
    showAlertOptions(
      context,
      msg: "¿Seguro que desea eliminar esta parada?",
      title: "Importante",
      acceptOnPressed: () async {
        Navigator.of(context).pop();
        globalLoading(context);
        final response = await stopService.deleteStop(id);
        if(response != null){
          if(response.status == "SUCCESS"){
            Navigator.of(context).pop();
            showAlertOptions(
              context,
              msg: response.msg!,
              title: "¡Enhorabuena!",
              closeOnPressed: () {
                Navigator.of(context).pop();
                getAllStops(context);
              },
            );
          } else {
            Navigator.of(context).pop();
            showAlertOptions(
              context,
              msg: response.msg!,
              title: "Importante",
            );
          }
        } else {
          Navigator.of(context).pop();
          showAlertOptions(
            context,
            msg: "Ha ocurrido un error con el servicio. Intente mas tarde",
            title: "Importante",
          );
        }
      },
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    log("[AdministrateStopController] disposed");
  }
}

final administrateStopsController = ChangeNotifierProvider.autoDispose((_) => AdministrateStopsController());