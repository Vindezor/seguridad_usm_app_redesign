import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:test_design/ui/map/map_controller.dart';

class MapPage extends ConsumerWidget {

  const MapPage({Key? key}) : super(key: key);
  
  final FloatingActionButtonLocation fabLocation = FloatingActionButtonLocation.centerDocked;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(mapController);
    log("[MapPage] reloaded");
    WidgetsBinding.instance.addPostFrameCallback((_) => controller.init());
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
        initialCameraPosition: controller.kGooglePlex,
        onMapCreated: controller.onMapCreated,
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
          heroTag: 'heroMap',
          onPressed: () => {
            controller.sendCoordinate()
          },
          backgroundColor: const Color(0xFFb04d1e),
          child: const Icon(
            Icons.notification_important,
            color: Color(0xFFefdbd2),
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
}