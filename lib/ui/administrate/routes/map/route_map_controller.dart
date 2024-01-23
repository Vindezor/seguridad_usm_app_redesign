import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:test_design/global/fit_map.dart';
import 'package:test_design/global/global_dialog.dart';
import 'package:test_design/global/global_loading.dart';
import 'package:test_design/models/here_route_model.dart';
import 'package:flexible_polyline/flexible_polyline.dart';
import 'package:test_design/models/routes_model.dart';
import 'package:test_design/services/route_service.dart';

class RouteMapController extends ChangeNotifier{
  FlutterSecureStorage storage = const FlutterSecureStorage();
  final CameraPosition initialCameraPosition = const CameraPosition(target: LatLng(10.480034, -66.903991), zoom: 12);
  late Completer<GoogleMapController> mapController;
  bool initialized = false;
  bool editing = false;
  Marker? marker;
  HereRouteModel? response;
  Set<Polyline> polyline = {};
  String? undecodedPolyline;
  Set<Marker> markers = {};

  final RouteService routeService = RouteService(Dio());

  RouteMapController(){
    mapController = Completer<GoogleMapController>();
    //requestPermission();
  }

  check(args){
    response = HereRouteModel.fromJson(args["response"]);
    editing = args["editing"];
    undecodedPolyline = response!.routes[0].sections[0].polyline;
    final points = FlexiblePolyline.decode(undecodedPolyline)
            .map((e) => LatLng(e.lat, e.lng))
            .toList();
    polyline = {};
    polyline.add(
      Polyline(
        polylineId: PolylineId(response!.routes[0].sections[0].id),
        points: points,
        color: const Color(0xFF3874c0),
        width: 5, 
      )
    );
    notifyListeners();
    initialized = true;
  }

  fitMapRoutes(LatLng origin, LatLng destination, GoogleMapController controller) async {
    await controller.animateCamera(
      fitMap(
        origin,
        destination,
        padding: 50,
      ),
    );
  }

  setOriginDestinationMarkers(LatLng origin, LatLng destination){
    markers = {};
    markers.add(
      Marker(
        markerId: const MarkerId("origin"),
        position: origin,
        //infoWindow: InfoWindow(title: "Salida")
      )
    );
    markers.add(
      Marker(
        markerId: const MarkerId("destination"),
        position: destination,
        //infoWindow: InfoWindow(title: "Destino")
      )
    );
    notifyListeners();
  }

  // requestPermission() async {
  //   try {
  //     log("[MapController] init");
  //     await Geolocator.requestPermission();
  //     pos = await Geolocator.getCurrentPosition();
  //     log('$pos');
  //   } catch (e) {
  //     log("$e");
  //   }
  // }

  confirm(context, args) async {
    globalLoading(context);
    RoutesModel? resp;
    if(editing){
      resp = await routeService.updateRoute(
        undecodedPolyline,
        args["id_departure"],
        args["id_arrival"],
        args["id"],
      );
    } else {
      resp = await routeService.createRoute(
        undecodedPolyline,
        args["id_departure"],
        args["id_arrival"],
      );
    }
    if(resp != null){
      if(resp.status == "SUCCESS"){
        Navigator.of(context).pop();
        showAlertOptions(
          context,
          msg: resp.msg!,
          title: "¡Enhorabuena!",
          closeOnPressed: () {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
        );
      } else {
        Navigator.of(context).pop();
        showAlertOptions(
          context,
          msg: resp.msg!,
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
    //Navigator.of(context).pop(marker!.position);
  }

  setMarker(LatLng pos){
    // marker = Marker(markerId: const MarkerId('Selected'), position: pos);
    // notifyListeners();
  }

  centerCameraMap(){
    // try {
    //   mapController.future.then((controller) => controller.animateCamera(CameraUpdate.newLatLngZoom(LatLng(pos!.latitude, pos!.longitude), 12)));
    // } catch (e) {
    //   log("$e");
    // }
  }

  onMapCreated(controller, args) async {
    mapController.complete(controller);
    final data = HereRouteModel.fromJson(args["response"]);
    final originPoint = LatLng(
      data.routes[0].sections[0].departure.place.location.lat,
      data.routes[0].sections[0].departure.place.location.lng,
    );
    final destinationPoint = LatLng(
      data.routes[0].sections[0].arrival.place.location.lat,
      data.routes[0].sections[0].arrival.place.location.lng,
    );
    setOriginDestinationMarkers(originPoint, destinationPoint);
    await fitMapRoutes(originPoint, destinationPoint, controller);

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    mapController.future.then((controller) => controller.dispose());
    log("[MapController] disposed");
  }
}

final routeMapController = ChangeNotifierProvider.autoDispose((_) => RouteMapController());