import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_design/global/global_dialog.dart';
import 'package:test_design/global/global_loading.dart';
import 'package:test_design/models/travel_model.dart';
import 'package:test_design/models/units_model.dart';
import 'package:test_design/services/unit_service.dart';

class AddEditModelController extends ChangeNotifier{

  final TextEditingController modelController = TextEditingController();

  final UnitService modelService = UnitService(Dio());

  bool checked = false;
  bool editing = false;

  List<Brand>? brands;

  int? selectedBrand;

  List<DropdownMenuItem<int>> brandItems = [];

  int? id;

  Model? model;

  AddEditModelController();

  check(args, context) async {
    checked = true;
    if(args != null){
      model = args["model"];
      modelController.text = model!.model;
      id = model!.id;
      selectedBrand = model!.brand.id;
      await getAllBrands(context);
      editing = true;
    }
    notifyListeners();
  }

  brandDropdownCallback(int? selectedValue) async {
    if(selectedValue is int){
      selectedBrand = selectedValue;
      notifyListeners();
    }
  }

  getAllBrands(context) async {
    globalLoading(context);
    final response = await modelService.getAllBrands();
    if(response != null){
      if(response.status == "SUCCESS"){
        Navigator.of(context).pop();
        brands = response.data;
        brandItems = [];
        brands!.map((brand) => brandItems.add(DropdownMenuItem<int>(value: brand.id, child: Text(brand.brand),))).toList();
        notifyListeners();
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
        throw Exception();
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
      throw Exception();
    }
  }

  changeModel(){
    notifyListeners();
  }

  // changeCoordinates(LatLng pos){
  //   coordinateController.text = '${pos.latitude},${pos.longitude}';
  //   notifyListeners();
  // }

  buttonDisabled(){
    if(modelController.value.text != ""){
      return false;
    }
    return true;
  }

  save(context) async {
    globalLoading(context);
    UnitsModel? response;
    if(editing) {
      response = await modelService.updateModel(id: id, model: modelController.value.text, idBrand: selectedBrand);
    } else {
      response = await modelService.createModel(model: modelController.value.text);
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
    modelController.dispose();
    log("[AddEditModelController] disposed");
  }
}

final addEditModelController = ChangeNotifierProvider.autoDispose((_) => AddEditModelController());