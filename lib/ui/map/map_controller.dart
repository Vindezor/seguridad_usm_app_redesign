// ignore_for_file: library_prefixes

import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:test_design/global/global_dialog.dart';
import 'package:test_design/global/global_loading.dart';
import 'package:test_design/services/travel_service.dart';

class MapController extends ChangeNotifier{
  FlutterSecureStorage storage = const FlutterSecureStorage();
  IO.Socket? socket;
  Position? pos;
  Timer? driverTimer;
  int? idTypeUser;
  bool travelEnded = false;
  final TravelService travelService = TravelService(Dio());
  late Completer<GoogleMapController> mapController;
  bool initialized = false;
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
    mapController = Completer<GoogleMapController>();
    driverTimer = null;
    requestPermission();
  }

  initSocket() async {
    initialized = true;
    final token = await storage.read(key: 'token');
    final idTravel = await storage.read(key: 'id_travel');
    idTypeUser = int.parse((await storage.read(key: 'id_type_user'))!);
    socket =  IO.io('http://192.168.0.109:3000/travel/$idTravel',
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
    if(idTypeUser == 1){
      socket!.on('endTravel', (_) {
        log("endTravel");
        socket!.disconnect();
        travelEnded = true;
        notifyListeners();
        // showAlertOptions(
        //   context!,
        //   msg: "El conductor ha terminado el viaje",
        //   title: "Importante",
        //   closeOnPressed: () {
        //     Navigator.of(context!).pop();
        //     Navigator.of(context!).pop();
        //   },
        // );
      });
    } else if (idTypeUser == 2){
      driverTimer = Timer.periodic(const Duration(seconds: 10), (timer) async {
        try {
          final currentPosition = await Geolocator.getCurrentPosition(timeLimit: const Duration(seconds: 8));
          final coordinate = "${currentPosition.latitude},${currentPosition.longitude}";
          socket!.emit('coordinate', coordinate);
        } catch (e) {
          log("$e");
        }
      });
    }
    notifyListeners();
  }

  void endTravel(context) {
    if(driverTimer != null){
      showAlertOptions(
        context,
        msg: '¿Seguro que desea finalizar el viaje?',
        title: 'Importante',
        acceptOnPressed: () async {
          Navigator.of(context).pop();
          globalLoading(context);
          final response = await travelService.endTravel();
          if(response != null) {
            Navigator.of(context).pop();
            if(response.status == "SUCCESS"){
              driverTimer!.cancel();
              showAlertOptions(
                context,
                msg: response.msg!,
                title: "Importante",
                closeOnPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
              );
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
        },
      );
    }
  }

  emergency(context){
    showAlertOptions(
      context,
      msg: "¿Esta seguro de que desea mandar una alerta de emergencia?",
      title: "Importante",
      acceptOnPressed: () async {
        Navigator.of(context).pop();
        globalLoading(context);
        final currentPosition = await Geolocator.getCurrentPosition(timeLimit: const Duration(seconds: 8));
        final coordinate = "${currentPosition.latitude},${currentPosition.longitude}";
        final response = await travelService.emergency(coordinate);
        if(response != null) {
          Navigator.of(context).pop();
          if(response.status == "SUCCESS"){
            driverTimer!.cancel();
            showAlertOptions(
              context,
              msg: response.msg,
              title: "Importante",
            );
          } else {
            showAlertOptions(
              context,
              msg: response.msg,
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
      },
    );
  }

  void addMorePeople(context) async {
    await storage.write(key: 'scanning_more', value: 'true');
    await Navigator.pushNamed(context, '/travel_qr_scanner');
    await storage.write(key: 'scanning_more', value: 'false');
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
    if(driverTimer!= null) driverTimer!.cancel();
    if(socket != null) socket!.dispose();
    log("[MapController] disposed");
  }
}

final mapController = ChangeNotifierProvider.autoDispose((_) => MapController());