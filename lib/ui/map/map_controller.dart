import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapController extends ChangeNotifier{


  Position? pos;
  final Completer<GoogleMapController> mapController = Completer<GoogleMapController>();

  final CameraPosition kGooglePlex = const CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  final CameraPosition _kLake = const CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);
  MapController(){
    requesPermission();
  }

  requesPermission() async {
    log("[MapController] init");
    await Geolocator.requestPermission();
    pos = await Geolocator.getCurrentPosition();
    log('$pos');
  }

  onMapCreated(controller){
    mapController.complete(controller);
  }

  Future<void> goToTheLake() async {
    final GoogleMapController controller = await mapController.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    mapController.future.then((controller) => controller.dispose());
    log("[MapController] disposed");
  }
}

final mapController = ChangeNotifierProvider.autoDispose((_) => MapController());