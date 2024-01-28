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
import 'package:test_design/models/stops_model.dart';
import 'package:test_design/models/travel_model.dart';
import 'package:test_design/services/travel_service.dart';
import 'package:test_design/ui/admin_map/travel_info/travel_info.dart';

class AdminMapController extends ChangeNotifier{
  FlutterSecureStorage storage = const FlutterSecureStorage();
  Timer? travelTimer;
  List<Travel>? travels;
  Travel? selectedTravel;
  Set<Polyline> polyline = {};
  Set<Marker> markers = {};
  BitmapDescriptor? icon;
  bool removing = false;


  final TravelService travelService = TravelService(Dio(BaseOptions(sendTimeout: const Duration(seconds: 9))));
  late Completer<GoogleMapController> mapController;
  bool initialized = false;
  final CameraPosition initialCameraPosition = const CameraPosition(target: LatLng(10.480034, -66.903991), zoom: 10);

  AdminMapController(){
    mapController = Completer<GoogleMapController>();
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
  }

  Future<void> getAllTravelNotEnded() async {
  final response = await travelService.getAllTravelNotEnded();
  
  if (response != null && !removing && response.status == "SUCCESS") {
    travels = response.data;
    removeBusMarkers();
    
    for (var travel in response.data!) {
      addBusMarker(travel);
    }

    notifyListeners();
  }
}

void removeBusMarkers() {
  markers.removeWhere((element) => element.markerId.value.startsWith("bus"));
}

void addBusMarker(Travel travel) {
  markers.add(
    Marker(
      anchor: const Offset(0, 0),
      markerId: MarkerId("bus${travel.id}"),
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
        removeStopMarkers();
        addStopMarkers(travel);
        addPolyline(travel);
        notifyListeners();
      },
    ),
  );
}

void removeStopMarkers() {
  markers.removeWhere((element) => element.markerId.value.startsWith("stop"));
}

void addStopMarkers(Travel travel) {
  addStopMarker(travel.route.departure);
  addStopMarker(travel.route.arrival);
}

void addStopMarker(Stop stop) {
  markers.add(
    Marker(
      markerId: MarkerId("stop${stop.id}"),
      position: LatLng(
        double.parse(stop.coordinate.split(",")[0]),
        double.parse(stop.coordinate.split(",")[1]),
      ),
      onTap: () => log("${stop.id}"),
    ),
  );
}

void addPolyline(Travel travel) {
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
    ),
  );
}


  showInfo(context){
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (_)  {
      return TravelInfo(selectedTravel: selectedTravel!,);
    }).then((value) {
      if(value == 'ended'){
        removing = true;
        markers.removeWhere((element) => element.markerId.value.startsWith("bus${selectedTravel!.id}") || element.markerId.value.startsWith("stop"));
        polyline = {};
        selectedTravel = null;
        mapController.future.then((controller) => controller.moveCamera(CameraUpdate.newCameraPosition(initialCameraPosition)));
        notifyListeners();
        removing = false;
      }
    },);
  }

  onMapCreated(controller, context) async {
    mapController.complete(controller);
    notifyListeners();
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