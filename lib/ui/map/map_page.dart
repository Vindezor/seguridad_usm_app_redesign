import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {

  @override
  void initState() async {
    // TODO: implement initState
    super.initState();
    await Geolocator.requestPermission();
    final pos = await Geolocator.getCurrentPosition();
    log('$pos');
  }

  final FloatingActionButtonLocation fabLocation = FloatingActionButtonLocation.centerDocked;


  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //extendBodyBehindAppBar: true,
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   backgroundColor: Colors.transparent,
      //   surfaceTintColor: Colors.transparent,
      //   title: const Text(
      //     "En ruta",
      //     style: TextStyle(
      //       fontWeight: FontWeight.bold,
      //       fontSize: 26,
      //       // shadows: [
      //       //   BoxShadow(
      //       //     color: Colors.black,
      //       //     blurRadius: 2,
      //       //     spreadRadius: 5,
      //       //     blurStyle: BlurStyle.outer
      //       //   )
      //       // ]
      //     ),
      //   ),
      // ),
      body: GoogleMap(
        compassEnabled: false,
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButtonLocation: fabLocation,
      floatingActionButton: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              blurRadius: 30,
              color: Colors.black,
              spreadRadius: -5,
            )
          ]
        ),
        child: FloatingActionButton.large(
          onPressed: () => {
            
          },
          backgroundColor: const Color(0xFFefdbd2),
          child: const Icon(
            Icons.notification_important,
            color: Color(0xFFb04d1e),
            size: 40,
            weight: 0.5,
          ),
        ),
      ),
      bottomNavigationBar: const BottomAppBar(
        shape: CircularNotchedRectangle(),
        color: Color(0xFF3874c0),
        // child: Row(
        //   children: [
        //     IconButton(
        //       tooltip: 'Open navigation menu',
        //       icon: const Icon(Icons.menu, color: Colors.white,),
        //       onPressed: () {},
        //     ),
        //     IconButton(
        //       tooltip: 'Open navigation menu',
        //       icon: const Icon(Icons.menu, color: Colors.white,),
        //       onPressed: () {},
        //     ),
        //     const Spacer(),
        //     IconButton(
        //       tooltip: 'Open navigation menu',
        //       icon: const Icon(Icons.menu, color: Colors.white,),
        //       onPressed: () {},
        //     ),
        //     IconButton(
        //       tooltip: 'Open navigation menu',
        //       icon: const Icon(Icons.menu, color: Colors.white,),
        //       onPressed: () {},
        //     ),
        //   ],
        // ),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }

  @override
  void dispose() async {
    // TODO: implement dispose
    super.dispose();
    (await _controller.future).dispose();
  }
}