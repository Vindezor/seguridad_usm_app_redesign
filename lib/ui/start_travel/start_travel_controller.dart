import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:test_design/global/global_dialog.dart';
import 'package:test_design/global/global_loading.dart';
import 'package:test_design/models/routes_model.dart' as route_model;
import 'package:test_design/models/travel_model.dart';
import 'package:test_design/services/route_service.dart';
import 'package:test_design/services/travel_service.dart';

class StartTravelController extends ChangeNotifier{

  final TravelService travelService = TravelService(Dio());
  final RouteService routeService = RouteService(Dio());
  final storage = const FlutterSecureStorage();
  StartTravelController(){
    log("[StartTravelController] init");
  }

  //int value;
  // final TextEditingController departureController = TextEditingController();
  // final TextEditingController arrivalController = TextEditingController();
  List<route_model.Route>? routes;
  List<DropdownMenuItem<int>> items = [];
  int? dropdownValue;
  //final UserService userService = UserService(Dio());

  void dropdownCallback(int? selectedValue){
    if(selectedValue is int){
      dropdownValue = selectedValue;
      notifyListeners();
    }
  }

  Future<void> getAllRoutes(context) async {
    globalLoading(context);
    final route_model.RoutesModel? response = await routeService.getAllRoutes();
    if(response != null){
      Navigator.of(context).pop();
      if(response.status == "SUCCESS"){
        routes = response.data;
        items = [];
        routes!.map((route) => items.add(DropdownMenuItem<int>(value: route.id,child: Text("${route.departure.name} - ${route.arrival.name}"),))).toList();
        notifyListeners();
        //Navigator.pushReplacementNamed(context, '/register_successful');
        // showAlertOptions(
        //   context,
        //   msg: "¡Bienvenido/a a nuestra plataforma de seguridad de transporte! Tu usuario se ha creado exitosamente. Por favor, revisa tu correo electrónico institucional (Terna) para encontrar una clave temporal. Tienes 30 minutos para iniciar sesión en la plataforma, de lo contrario, tu cuenta será eliminada del sistema. ¡Gracias por elegirnos y viajar seguro!",
        //   title: "Importante",
        //   justified: true,
        //   closeOnPressed: () {
        //     Navigator.of(context).pop();
        //     Navigator
        //   },
        // );
      } else {
        showAlertOptions(
          context,
          msg: response.msg!,
          title: "Importante",
          closeOnPressed: () {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
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
        },
      );
    }
  }

  void startTravel(context) async {
    globalLoading(context);
    await Geolocator.requestPermission();
    final currentPosition = await Geolocator.getCurrentPosition();
    final coordinate = "${currentPosition.latitude},${currentPosition.longitude}";
    final TravelModel? response = await travelService.createTravel(coordinate, dropdownValue!);
    if(response != null){
      Navigator.of(context).pop();
      if(response.status == "SUCCESS"){
        storage.write(key: 'id_travel', value: response.data!.id.toString());
        Navigator.of(context).pushReplacementNamed('/travel_qr_scanner');
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
  }

  bool startTravelButtonDisabled(){
    if(dropdownValue != null){
      return false;
    }
    return true;
  }

  // void changeTextValue(String text){
  //   textEditingController.text = text;
  //   notifyListeners();
  // }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // departureController.dispose();
    // arrivalController.dispose();
    log("[StartTravelController] disposed");
  }
}

final startTravelController = ChangeNotifierProvider.autoDispose((_) => StartTravelController());