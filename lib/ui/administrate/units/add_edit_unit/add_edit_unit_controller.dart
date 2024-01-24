import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_design/global/global_dialog.dart';
import 'package:test_design/global/global_loading.dart';
import 'package:test_design/models/login_model.dart';
import 'package:test_design/models/travel_model.dart';
import 'package:test_design/models/units_model.dart';
import 'package:test_design/services/unit_service.dart';
import 'package:test_design/services/user_service.dart';

class AddEditUnitController extends ChangeNotifier{

  final TextEditingController plateController = TextEditingController();
  final TextEditingController yearController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  final UnitService unitService = UnitService(Dio());
  final UserService driverService = UserService(Dio());

  bool checked = false;
  bool editing = false;

  Unit? unit;
  List<User>? drivers;
  List<Brand>? brands;
  List<Model>? models;

  int? selectedDriver;
  int? selectedModel;
  int? selectedBrand;
  List<DropdownMenuItem<int>> driverItems = [];
  List<DropdownMenuItem<int>> brandItems = [];
  List<DropdownMenuItem<int>> modelItems = [];

  AddEditUnitController();

  check(args, context) async {
    checked = true;
    if(args != null){
      try{
        unit = args["unit"];
        plateController.text = unit!.plate;
        yearController.text = unit!.year;
        descriptionController.text = unit!.description;
        await getAllDrivers(context);
        selectedDriver = unit!.driver!.id;
        selectedModel = unit!.model.id;
        selectedBrand = unit!.model.brand.id;
        await getAllBrands(context);
        await getAllModelsByIdBrand(context, selectedBrand);
        editing = true;
      } catch (e){
        log("$e");
      }
    } else {
      try{
        await getAllDrivers(context);
        await getAllBrands(context);
      } catch (e){
        log("$e");
      }
    }
    notifyListeners();
  }
  
  getAllModelsByIdBrand(context, idBrand) async {
    globalLoading(context);
    final response = await unitService.getAllModelsByIdBrand(idBrand);
    if(response != null){
      if(response.status == "SUCCESS"){
        Navigator.of(context).pop();
        models = response.data;
        modelItems = [];
        models!.map((model) => modelItems.add(DropdownMenuItem<int>(value: model.id, child: Text(model.model),))).toList();
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

  getAllBrands(context) async {
    globalLoading(context);
    final response = await unitService.getAllBrands();
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

  getAllDrivers(context) async {
    globalLoading(context);
    final response = await driverService.getAllDrivers();
    if(response != null){
      if(response.status == "SUCCESS"){
        Navigator.of(context).pop();
        drivers = response.data;
        driverItems = [];
        drivers!.map((driver) => driverItems.add(DropdownMenuItem<int>(value: driver.id, child: Text("${driver.document} - ${driver.fullName}"),))).toList();
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

  driverDropdownCallback(int? selectedValue){
    if(selectedValue is int){
      selectedDriver = selectedValue;
      notifyListeners();
    }
  }

  brandDropdownCallback(int? selectedValue, context) async {
    if(selectedValue is int){
      selectedBrand = selectedValue;
      notifyListeners();
      await getAllModelsByIdBrand(context, selectedBrand);
    }
  }

  modelDropdownCallback(int? selectedValue){
    if(selectedValue is int){
      selectedModel = selectedValue;
      notifyListeners();
    }
  }

  changeName(){
    notifyListeners();
  }

  // changeCoordinates(LatLng pos){
  //   coordinateController.text = '${pos.latitude},${pos.longitude}';
  //   notifyListeners();
  // }

  buttonDisabled(){
    // if(nameController.value.text != "" && coordinateController.value.text != ""){
    //   return false;
    // }
    return true;
  }

  save(context) async {
    globalLoading(context);
    UnitsModel? response;
    if(editing) {
      response = await unitService.updateUnit(
        id: unit!.id,
        plate: plateController.value.text,
        year: yearController.value.text,
        description: descriptionController.value.text
      );
    } else {
      response = await unitService.createUnit(
        plate: plateController.value.text,
        year: yearController.value.text,
        description: descriptionController.value.text
      );
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
    yearController.dispose();
    plateController.dispose();
    descriptionController.dispose();
    scrollController.dispose();
    log("[AddEditUnitController] disposed");
  }
}

final addEditUnitController = ChangeNotifierProvider.autoDispose((_) => AddEditUnitController());