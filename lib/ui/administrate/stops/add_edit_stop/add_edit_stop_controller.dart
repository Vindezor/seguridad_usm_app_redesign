import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:test_design/global/global_dialog.dart';
import 'package:test_design/global/global_loading.dart';
import 'package:test_design/models/stops_model.dart';
import 'package:test_design/services/stop_service.dart';

class AddEditStopController extends ChangeNotifier{

  final TextEditingController nameController = TextEditingController();
  final TextEditingController coordinateController = TextEditingController();

  final StopService stopService = StopService(Dio());

  bool checked = false;
  bool editing = false;

  int? id;

  final RegExp stopRegex = RegExp(r'^[a-zA-Z0-9áéíóúÁÉÍÓÚüÜ]+(?:\s[a-zA-Z0-9áéíóúÁÉÍÓÚüÜ]+)*$');

  final FocusNode stopFocusNode = FocusNode();

  bool stopTouched = false;

  AddEditStopController(){
    stopFocusNode.addListener(() {
      stopTouched = true;
    });
  }

  check(args){
    if(args != null){
      nameController.text = args["name"];
      coordinateController.text = args["coordinate"];
      id = args["id"];
      editing = true;
    }
    checked = true;
    notifyListeners();
  }

  changeName(){
    notifyListeners();
  }

  stopIsBad(){
    if(stopRegex.hasMatch(nameController.value.text)){
      return false;
    }
    return true;
  }

  changeCoordinates(LatLng pos){
    coordinateController.text = '${pos.latitude},${pos.longitude}';
    notifyListeners();
  }

  buttonDisabled(){
    if(stopRegex.hasMatch(nameController.value.text) && coordinateController.value.text != ""){
      return false;
    }
    return true;
  }

  save(context) async {
    globalLoading(context);
    StopsModel? response;
    if(editing) {
      response = await stopService.updateStop(id, nameController.value.text, coordinateController.value.text);
    } else {
      response = await stopService.createStop(nameController.value.text, coordinateController.value.text);
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
    nameController.dispose();
    coordinateController.dispose();
    stopFocusNode.dispose();
    log("[AddEditStopController] disposed");
  }
}

final addEditStopController = ChangeNotifierProvider.autoDispose((_) => AddEditStopController());