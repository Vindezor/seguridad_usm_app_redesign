import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_design/global/global_dialog.dart';
import 'package:test_design/global/global_loading.dart';
import 'package:test_design/models/units_model.dart';
import 'package:test_design/services/unit_service.dart';

class AddEditBrandController extends ChangeNotifier{

  final TextEditingController brandController = TextEditingController();

  final UnitService brandService = UnitService(Dio());

  bool checked = false;
  bool editing = false;

  int? id;

  final RegExp brandRegex = RegExp(r'^[A-Za-z](?:[A-Za-z\s\-]{0,18}[A-Za-z])?$');


  final FocusNode brandFocusNode = FocusNode();

  bool brandTouched = false;

  AddEditBrandController(){
    brandFocusNode.addListener(() {
      brandTouched = true;
    });
  }

  check(args){
    if(args != null){
      brandController.text = args["brand"];
      id = args["id"];
      editing = true;
    }
    checked = true;
    notifyListeners();
  }

  changeBrand(){
    notifyListeners();
  }

  // changeCoordinates(LatLng pos){
  //   coordinateController.text = '${pos.latitude},${pos.longitude}';
  //   notifyListeners();
  // }

  buttonDisabled(){
    if(brandRegex.hasMatch(brandController.value.text)){
      return false;
    }
    return true;
  }

  save(context) async {
    globalLoading(context);
    UnitsModel? response;
    if(editing) {
      response = await brandService.updateBrand(id: id, brand: brandController.value.text);
    } else {
      response = await brandService.createBrand(brand: brandController.value.text);
    }
    if(response != null){
      if(response.status == "SUCCESS"){
        Navigator.of(context).pop();
        showAlertOptions(
          context,
          msg: response.msg!,
          title: "¡Enhorabuena!",
          closeOnPressed: () {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          }
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
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    brandController.dispose();
    brandFocusNode.dispose();
    log("[AddEditBrandController] disposed");
  }
}

final addEditBrandController = ChangeNotifierProvider.autoDispose((_) => AddEditBrandController());