import 'dart:async';
import 'dart:developer';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:dio/dio.dart';
import 'package:flexible_polyline/flexible_polyline.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:test_design/global/fit_map.dart';
import 'package:test_design/models/travel_model.dart';
import 'package:test_design/services/travel_service.dart';
import 'package:test_design/ui/admin_map/travel_info/travel_info.dart';

class AdminMapController extends ChangeNotifier{
  FlutterSecureStorage storage = const FlutterSecureStorage();
  // IO.Socket? socket;
  // Position? pos;
  Timer? travelTimer;
  // int? idTypeUser;
  // bool travelEnded = false;
  List<Travel>? travels;
  Travel? selectedTravel;
  Set<Polyline> polyline = {};
  Set<Marker> markers = {};
  BitmapDescriptor? icon;

  final TravelService travelService = TravelService(Dio(BaseOptions(sendTimeout: const Duration(seconds: 9))));
  late Completer<GoogleMapController> mapController;
  bool initialized = false;
  final CameraPosition initialCameraPosition = const CameraPosition(target: LatLng(10.480034, -66.903991), zoom: 10);

  AdminMapController(){
    mapController = Completer<GoogleMapController>();
    // driverTimer = null;
    // requestPermission();
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }

  initMap() async {
    initialized = true;
    final Uint8List markerIcon = await getBytesFromAsset('assets/bus-icon-a.png', 150);
    icon = BitmapDescriptor.fromBytes(markerIcon);
    getAllTravelNotEnded();
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
        travels = response.data;
        markers.removeWhere((element) => element.markerId.value.startsWith("bus"));
        response.data!.map((travel) async {
          markers.add(
            Marker(
              anchor: const Offset(0,0),
              markerId: MarkerId(
                "bus${travel.id.toString()}"
              ),
              position: LatLng(
                double.parse(travel.coordinate.split(",")[0]),
                double.parse(travel.coordinate.split(",")[1]),
              ),
              icon: icon!,
              onTap: () {
                selectedTravel = travel;
                final origin = LatLng(
                  double.parse(travel.route.departure.coordinate.split(",")[0]),
                  double.parse(travel.route.departure.coordinate.split(",")[1]),
                );
                final destination = LatLng(
                  double.parse(travel.route.arrival.coordinate.split(",")[0]),
                  double.parse(travel.route.arrival.coordinate.split(",")[1]),
                );
                mapController.future.then((controller) => fitMapRoutes(origin, destination, controller));
                markers.removeWhere((element) => element.markerId.value.startsWith("stop"));
                markers.add(
                  Marker(
                    //anchor: const Offset(0,0),
                    markerId: MarkerId(
                      "stop${travel.route.departure.id}"
                    ),
                    position: origin,
                    onTap: () => {
                      log("${travel.id}")
                    }
                  )
                );
                markers.add(
                  Marker(
                    //anchor: const Offset(0,0),
                    markerId: MarkerId(
                      "stop${travel.route.arrival.id}"
                    ),
                    position: destination,
                    onTap: () => {
                      log("${travel.id}")
                    }
                  )
                );
                final points = FlexiblePolyline.decode(travel.route.route)
                  .map((e) => LatLng(e.lat, e.lng))
                  .toList();
                  polyline = {};
                polyline.add(
                  Polyline(
                    polylineId: PolylineId("route${travel.id.toString()}"),
                    points: points,
                    color: const Color(0xFF3874c0),
                    width: 5,
                  )
                );
                notifyListeners();
              }
            )
          );
        }).toList();
        notifyListeners();
      }
    }
  }

  showInfo(context){
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (_)  {
      return TravelInfo(selectedTravel: selectedTravel!,);
    });
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