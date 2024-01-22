import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:test_design/global/global_dialog.dart';
import 'package:test_design/ui/map/map_controller.dart';

class MapPage extends ConsumerWidget {

  const MapPage({Key? key}) : super(key: key);
  
  final FloatingActionButtonLocation fabLocation = FloatingActionButtonLocation.centerDocked;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(mapController);
    log("[MapPage] reloaded");
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if(!controller.initialized){
        controller.initSocket();
      }
      if(controller.travelEnded){
        showAlertOptions(
          context,
          msg: "El conductor ha terminado el viaje",
          title: "Importante",
          closeOnPressed: () {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
        );
      }
    });
    return PopScope(
      canPop: false,
      child: Scaffold(
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
          polylines: controller.polyline,
          markers: controller.markers,
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          compassEnabled: false,
          mapType: MapType.normal,
          initialCameraPosition: controller.initialCameraPosition,
          onMapCreated: (mapController) async => controller.onMapCreated(mapController, context),
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
            onPressed: () => controller.emergency(context),
            backgroundColor: const Color(0xFFb04d1e),
            child: const Icon(
              Icons.notification_important,
              color: Color(0xFFefdbd2),
              size: 40,
              weight: 0.5,
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          color: const Color(0xFF3874c0),
          child: controller.idTypeUser != null ? controller.idTypeUser == 2 ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: [
              IconButton(
                onPressed: () => controller.addMorePeople(context),
                icon: const Icon(Icons.person_add,),
                iconSize: 35,
                color: const Color(0xFFddeaf4),
              ),
              const SizedBox(width: 120,),
              IconButton(
                onPressed: () => controller.endTravel(context),
                icon: const Icon(Icons.cancel),
                iconSize: 35,
                color: const Color(0xFFddeaf4),
              ),
            ],
          ) : const SizedBox() : const SizedBox(),
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
      ),
    );
  }
}