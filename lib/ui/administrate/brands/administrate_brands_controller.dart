import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_design/global/global_dialog.dart';
import 'package:test_design/global/global_loading.dart';
import 'package:test_design/models/travel_model.dart';
import 'package:test_design/services/unit_service.dart';

class AdministrateBrandsController extends ChangeNotifier{

  final UnitService brandService = UnitService(Dio());
  List<Brand>? brands;

  AdministrateBrandsController();

  getAllBrands(context) async {
    globalLoading(context);
    final response = await brandService.getAllBrands();
    if(response != null){
      if(response.status == "SUCCESS"){
        brands = response.data;
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

  deleteBrand(context, id){
    showAlertOptions(
      context,
      msg: "¿Seguro que desea eliminar esta marca?",
      title: "Importante",
      acceptOnPressed: () async {
        Navigator.of(context).pop();
        globalLoading(context);
        final response = await brandService.deleteBrand(id);
        if(response != null){
          if(response.status == "SUCCESS"){
            Navigator.of(context).pop();
            showAlertOptions(
              context,
              msg: response.msg!,
              title: "¡Enhorabuena!",
              closeOnPressed: () {
                Navigator.of(context).pop();
                getAllBrands(context);
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
    log("[AdministrateBrandController] disposed");
  }
}

final administrateBrandsController = ChangeNotifierProvider.autoDispose((_) => AdministrateBrandsController());