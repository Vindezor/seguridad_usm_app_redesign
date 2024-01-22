// ignore_for_file: library_prefixes

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:test_design/global/global_dialog.dart';
import 'package:test_design/global/global_loading.dart';
import 'package:test_design/models/routes_model.dart' as RM;
import 'package:test_design/models/stops_model.dart';
import 'package:test_design/services/route_service.dart';
import 'package:test_design/services/stop_service.dart';

class AdministrateRoutesController extends ChangeNotifier{

  final RouteService routeService = RouteService(Dio());
  final StopService stopService = StopService(Dio());
  
  List<RM.Route>? routes;
  List<Stop> stops = [];
  
  List<DropdownMenuItem<int>> selectDepartureItems = [];
  List<DropdownMenuItem<int>> selectArrivalItems = [];
  int? departureValue;
  int? arrivalValue;

  AdministrateRoutesController(){
    log("[AdministrateRoutesController] init");
  }

  Future<void> getAllRoutes(context) async {
    globalLoading(context);
    final response = await routeService.getAllRoutes();
    if(response != null){
      if(response.status == "SUCCESS"){
        routes = response.data;
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

  deleteRoute(context, id){
    showAlertOptions(
      context,
      msg: "¿Seguro que desea eliminar esta parada?",
      title: "Importante",
      acceptOnPressed: () async {
        Navigator.of(context).pop();
        globalLoading(context);
        final response = await routeService.deleteRoute(id);
        if(response != null){
          if(response.status == "SUCCESS"){
            Navigator.of(context).pop();
            showAlertOptions(
              context,
              msg: response.msg!,
              title: "¡Enhorabuena!",
              closeOnPressed: () {
                Navigator.of(context).pop();
                getAllRoutes(context);
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

  getAllStops(context) async {
    stops = [];
    globalLoading(context);
    final response = await stopService.getAllStop();
    if(response != null){
      if(response.status == "SUCCESS"){
        stops = response.data!;
        selectDepartureItems = [];
        selectArrivalItems = [];
        stops.map((stop) {
          selectDepartureItems.add(
            DropdownMenuItem<int>(
              value: stop.id,
              //enabled: (arrivalValue != stop.id),
              child: Text(
                stop.name,
                // style: TextStyle(
                //   color: (arrivalValue != stop.id) ? Colors.black : Colors.black26
                // ),
              ),
            ),
          );
          selectArrivalItems.add(
            DropdownMenuItem<int>(
              value: stop.id,
              //enabled: (departureValue != stop.id),
              child: Text(
                stop.name,
                // style: TextStyle(
                //   color: (departureValue != stop.id) ? Colors.black : Colors.black26
                // ),
              ),
            ),
          );
        }).toList();
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

  save(context){

  }

  goToAddRoute(context) async {
    await getAllStops(context);
    if(stops.isNotEmpty){
      Navigator.of(context).pushNamed('/add_edit_route').then((value) => getAllRoutes(context));
    }
  }

  goToEditRoute(context, id, Stop departure, Stop arrival) async {
    await getAllStops(context);
    if(stops.isNotEmpty){
      departureValue = departure.id;
      arrivalValue = arrival.id;
      Navigator.of(context).pushNamed('/add_edit_route', arguments: {
        "id": id,
        // "departure": departure.toJson(),
        // "arrival": arrival.toJson(),
      }).then((result) {
        getAllRoutes(context);
      });
    }
  }

  generateRoute(context) async {
    globalLoading(context);
    final origin = stops.where((stop) => stop.id == departureValue).toList().first.coordinate;
    final destination = stops.where((stop) => stop.id == arrivalValue).toList().first.coordinate;
    final response = await routeService.getRouteBetweenPoints(
      origin: LatLng(
        double.parse(origin.split(",")[0]),
        double.parse(origin.split(",")[1])
      ),
      destination: LatLng(
        double.parse(destination.split(",")[0]),
        double.parse(destination.split(",")[1])
      ),
    );
    if(response != null){
      if(response.routes.isNotEmpty){
        Navigator.of(context).pop();
        Navigator.of(context).pushNamed('/route_map', arguments:{ "response": response.toJson() });
      } else {
        Navigator.of(context).pop();
        showAlertOptions(
          context,
          msg: "No se han encontrado rutas entre esas paradas",
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

  generateRouteButtonDisabled(){
    if(departureValue != arrivalValue){
      return false;
    }
    return true;
  }

  void departureDropdownCallback(int? selectedValue){
    if(selectedValue is int){
      departureValue = selectedValue;
      notifyListeners();
    }
  }

  void arrivalDropdownCallback(int? selectedValue){
    if(selectedValue is int){
      arrivalValue = selectedValue;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    log("[AdministrateRoutesController] disposed");
  }
}

final administrateRoutesController = ChangeNotifierProvider.autoDispose((_) => AdministrateRoutesController());