import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_design/global/global_dialog.dart';
import 'package:test_design/global/global_loading.dart';
import 'package:test_design/models/travel_model.dart';
import 'package:test_design/services/unit_service.dart';

class AdministrateModelsController extends ChangeNotifier{

  final UnitService modelService = UnitService(Dio());
  List<Model>? models;

  AdministrateModelsController();

  getAllModels(context) async {
    globalLoading(context);
    final response = await modelService.getAllModels();
    if(response != null){
      if(response.status == "SUCCESS"){
        models = response.data;
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

  deleteModel(context, id){
    showAlertOptions(
      context,
      msg: "¿Seguro que desea eliminar este modelo?",
      title: "Importante",
      acceptOnPressed: () async {
        Navigator.of(context).pop();
        globalLoading(context);
        final response = await modelService.deleteModel(id);
        if(response != null){
          if(response.status == "SUCCESS"){
            Navigator.of(context).pop();
            showAlertOptions(
              context,
              msg: response.msg!,
              title: "¡Enhorabuena!",
              closeOnPressed: () {
                Navigator.of(context).pop();
                getAllModels(context);
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
    log("[AdministrateModelController] disposed");
  }
}

final administrateModelsController = ChangeNotifierProvider.autoDispose((_) => AdministrateModelsController());