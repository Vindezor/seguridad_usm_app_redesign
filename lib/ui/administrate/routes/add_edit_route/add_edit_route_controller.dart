import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_design/services/route_service.dart';

class AddEditRouteController extends ChangeNotifier{

  final RouteService routeService = RouteService(Dio());

  bool checked = false;
  bool editing = false;

  int? id;

  final FocusNode arrivalFocusNode = FocusNode();
  final FocusNode departureFocusNode = FocusNode();

  bool arrivalTouched = false;
  bool departureTouched = false;


  AddEditRouteController(){
    log("[AddEditRouteController] init");
    arrivalFocusNode.addListener(() {
      arrivalTouched = true;
      notifyListeners();
    });
    departureFocusNode.addListener(() {
      departureTouched = true;
      notifyListeners();
    });
  }

  check(args){
    if(args != null){
      id = args["id"];
      editing = true;
    }
    checked = true;
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
    // globalLoading(context);
    // RoutesModel? response;
    // if(editing) {
    //   response = await routeService.updateRoute(id, nameController.value.text, coordinateController.value.text);
    // } else {
    //   response = await routeService.createRoute(nameController.value.text, coordinateController.value.text);
    // }
    // if(response != null){
    //   if(response.status == "SUCCESS"){
    //     Navigator.of(context).pop();
    //     showAlertOptions(
    //       context,
    //       msg: response.msg!,
    //       title: "¡Enhorabuena!",
    //       closeOnPressed: () {
    //         Navigator.of(context).pop();
    //         Navigator.of(context).pop();
    //       }
    //     );
    //   } else {
    //     Navigator.of(context).pop();
    //     showAlertOptions(
    //       context,
    //       msg: response.msg!,
    //       title: "Importante",
    //     );
    //   }
    // } else {
    //   Navigator.of(context).pop();
    //   showAlertOptions(
    //     context,
    //     msg: "Ha ocurrido un error con el servicio. Intente mas tarde",
    //     title: "Importante",
    //   );
    // }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    departureFocusNode.dispose();
    arrivalFocusNode.dispose();
    log("[AddEditRouteController] disposed");
  }
}

final addEditRouteController = ChangeNotifierProvider.autoDispose((_) => AddEditRouteController());