// ignore_for_file: library_prefixes

import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class MapController extends ChangeNotifier{
  FlutterSecureStorage storage = const FlutterSecureStorage();
  IO.Socket? socket;
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
    zoom: 19.151926040649414
  );

  MapController(){
    requestPermission();
  }

  initSocket() async {
    final token = await storage.read(key: 'token');
    final idTravel = await storage.read(key: 'id_travel');
    socket =  IO.io('http://172.16.90.127:3000/travel/$idTravel',
      IO.OptionBuilder()
        .disableAutoConnect()
        .setTransports(['websocket'])
        .setQuery({ "token": token})
        .build()
    );

    socket!.connect();
    socket!.on('connect', (_) {
      log('connect');
    });
    socket!.onError((data) => log("$data"));
    socket!.on('event', (data) => log(data));
    socket!.onDisconnect((_) => log('disconnect'));
    socket!.on('fromServer', (_) => log(_));

  }

  sendCoordinate(){
    socket!.emit('coordinate', '1234');
  }

  requestPermission() async {
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
    if(socket != null) socket!.dispose();
    log("[MapController] disposed");
  }
}

final mapController = ChangeNotifierProvider.autoDispose((_) => MapController());