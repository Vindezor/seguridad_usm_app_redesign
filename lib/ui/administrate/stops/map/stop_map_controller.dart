import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class StopMapController extends ChangeNotifier{
  FlutterSecureStorage storage = const FlutterSecureStorage();
  Position? pos;
  final CameraPosition initialCameraPosition = const CameraPosition(target: LatLng(10.480034, -66.903991), zoom: 12);
  late Completer<GoogleMapController> mapController;
  bool initialized = false;
  Marker? marker;
  StopMapController(){
    mapController = Completer<GoogleMapController>();
    //requestPermission();
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

  confirm(context){
    Navigator.of(context).pop(marker!.position);
  }

  setMarker(LatLng pos){
    marker = Marker(markerId: const MarkerId('Selected'), position: pos);
    notifyListeners();
  }

  centerCameraMap(){
    try {
      mapController.future.then((controller) => controller.animateCamera(CameraUpdate.newLatLngZoom(LatLng(pos!.latitude, pos!.longitude), 12)));
    } catch (e) {
      log("$e");
    }
  }

  onMapCreated(controller){
    mapController.complete(controller);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    mapController.future.then((controller) => controller.dispose());
    log("[MapController] disposed");
  }
}

final stopMapController = ChangeNotifierProvider.autoDispose((_) => StopMapController());