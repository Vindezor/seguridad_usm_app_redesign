import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:test_design/global/fit_map.dart';
import 'package:test_design/services/travel_service.dart';

class AdminMapController extends ChangeNotifier{
  FlutterSecureStorage storage = const FlutterSecureStorage();
  // IO.Socket? socket;
  // Position? pos;
  Timer? travelTimer;
  // int? idTypeUser;
  // bool travelEnded = false;

  Set<Polyline> polyline = {};
  Set<Marker> markers = {};
  BitmapDescriptor? icon;

  final TravelService travelService = TravelService(Dio());
  late Completer<GoogleMapController> mapController;
  bool initialized = false;
  final CameraPosition initialCameraPosition = const CameraPosition(target: LatLng(10.480034, -66.903991), zoom: 12);

  AdminMapController(){
    mapController = Completer<GoogleMapController>();
    // driverTimer = null;
    // requestPermission();
  }

  initSocket() async {
    initialized = true;
    BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(
        size: Size(5, 5)
      ),
      'assets/bus-icon-a.png'
    ).then((iconGot) {
      icon = iconGot;
      travelTimer = Timer.periodic(
        const Duration(seconds: 10),
        (timer) {
          try {
            getAllTravelNotEnded();
          } catch (e) {
            log("$e");
          }
        }
      );
    });
    // final token = await storage.read(key: 'token');
    // final idTravel = await storage.read(key: 'id_travel');
    // idTypeUser = int.parse((await storage.read(key: 'id_type_user'))!);
    // socket =  IO.io('http://172.16.90.127:3000/travel/$idTravel',
    //   IO.OptionBuilder()
    //     .disableAutoConnect()
    //     .setTransports(['websocket'])
    //     .setQuery({ "token": token})
    //     .build()
    // );

    // socket!.connect();
    // socket!.on('connect', (_) {
    //   log('connect');
    // });
    // socket!.onError((data) => log("$data"));
    // socket!.on('event', (data) => log(data));
    // socket!.onDisconnect((_) => log('disconnect'));
    // socket!.on('fromServer', (_) => log(_));
    // if(idTypeUser == 1){
    //   socket!.on('endTravel', (_) {
    //     log("endTravel");
    //     socket!.disconnect();
    //     travelEnded = true;
    //     notifyListeners();
    //     // showAlertOptions(
    //     //   context!,
    //     //   msg: "El conductor ha terminado el viaje",
    //     //   title: "Importante",
    //     //   closeOnPressed: () {
    //     //     Navigator.of(context!).pop();
    //     //     Navigator.of(context!).pop();
    //     //   },
    //     // );
    //   });
    // } else if (idTypeUser == 2){
    //   driverTimer = Timer.periodic(const Duration(seconds: 10), (timer) async {
    //     try {
    //       final currentPosition = await Geolocator.getCurrentPosition(timeLimit: const Duration(seconds: 8));
    //       final coordinate = "${currentPosition.latitude},${currentPosition.longitude}";
    //       socket!.emit('coordinate', coordinate);
    //     } catch (e) {
    //       log("$e");
    //     }
    //   });
    // }
    // notifyListeners();
  }

  getAllTravelNotEnded() async {
    final response = await travelService.getAllTravelNotEnded();
    if(response != null){
      if(response.status == "SUCCESS"){
        response.data!.map((travel) async {
          markers.add(
            Marker(
              anchor: const Offset(0,0),
              markerId: MarkerId(
                travel.id.toString()
              ),
              position: LatLng(
                double.parse(travel.coordinate.split(",")[0]),
                double.parse(travel.coordinate.split(",")[1]),
              ),
              icon: icon!,
            )
          );
        }).toList();
        notifyListeners();
      }
    }
  }

  

  // emergency(context){
  //   showAlertOptions(
  //     context,
  //     msg: "¿Esta seguro de que desea mandar una alerta de emergencia?",
  //     title: "Importante",
  //     acceptOnPressed: () async {
  //       Navigator.of(context).pop();
  //       globalLoading(context);
  //       final currentPosition = await Geolocator.getCurrentPosition(timeLimit: const Duration(seconds: 8));
  //       final coordinate = "${currentPosition.latitude},${currentPosition.longitude}";
  //       final response = await travelService.emergency(coordinate);
  //       if(response != null) {
  //         Navigator.of(context).pop();
  //         if(response.status == "SUCCESS"){
  //           driverTimer!.cancel();
  //           showAlertOptions(
  //             context,
  //             msg: response.msg,
  //             title: "Importante",
  //           );
  //         } else {
  //           showAlertOptions(
  //             context,
  //             msg: response.msg,
  //             title: "Importante"
  //           );
  //         }
  //       } else {
  //         Navigator.of(context).pop();
  //         showAlertOptions(
  //           context,
  //           msg: "Ha ocurrido un error con el servicio. Intente mas tarde",
  //           title: "Importante"
  //         );
  //       }
  //     },
  //   );
  // }

  // requestPermission() async {
  //   log("[MapController] init");
  //   await Geolocator.requestPermission();
  //   pos = await Geolocator.getCurrentPosition();
  //   log('$pos');
  // }

  onMapCreated(controller, context) async {
    mapController.complete(controller);
    notifyListeners();
    // final idTravel = await storage.read(key: 'id_travel');
    // final response = await travelService.findTravelById(idTravel);
    // if(response != null) {
    //   if(response.status == "SUCCESS"){
    //     final undecodedPolyline = response.data!.route.route;
    //     final points = FlexiblePolyline.decode(undecodedPolyline)
    //             .map((e) => LatLng(e.lat, e.lng))
    //             .toList();
    //     polyline = {};
    //     polyline.add(
    //       Polyline(
    //         polylineId: PolylineId("${response.data!.route.id}"),
    //         points: points,
    //         color: const Color(0xFF3874c0),
    //         width: 5, 
    //       )
    //     );
    //     markers = {};
    //     final departureCords = response.data!.route.departure.coordinate.split(",");
    //     final arrivalCords = response.data!.route.arrival.coordinate.split(",");
    //     final origin = LatLng(double.parse(departureCords[0]), double.parse(departureCords[1]));
    //     final destination = LatLng(double.parse(arrivalCords[0]), double.parse(arrivalCords[1]));
    //     markers.add(
    //       Marker(
    //         markerId: const MarkerId("departure"),
    //         position: origin,
    //         //infoWindow: InfoWindow(title: "Salida")
    //       )
    //     );
    //     markers.add(
    //       Marker(
    //         markerId: const MarkerId("arrival"),
    //         position: destination,
    //         //infoWindow: InfoWindow(title: "Destino")
    //       )
    //     );
    //     fitMapRoutes(origin, destination, controller);
    //     notifyListeners();
    //   } else {
    //     showAlertOptions(
    //       context,
    //       msg: response.msg!,
    //       title: "Importante"
    //     );
    //   }
    // } else {
    //   Navigator.of(context).pop();
    //   showAlertOptions(
    //     context,
    //     msg: "Ha ocurrido un error con el servicio. Intente mas tarde",
    //     title: "Importante"
    //   );
    // }
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

  // Future<void> goToTheLake() async {
  //   final GoogleMapController controller = await mapController.future;
  //   await controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  // }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    mapController.future.then((controller) => controller.dispose());
    travelTimer!.cancel();
    // if(driverTimer!= null) driverTimer!.cancel();
    // if(socket != null) socket!.dispose();
    log("[AdminMapController] disposed");
  }
}

final adminMapController = ChangeNotifierProvider.autoDispose((_) => AdminMapController());