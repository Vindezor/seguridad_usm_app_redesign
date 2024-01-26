import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:icon_decoration/icon_decoration.dart';
import 'package:stroke_text/stroke_text.dart';
import 'package:test_design/ui/admin_map/admin_map_controller.dart';

class AdminMapPage extends ConsumerWidget {

  const AdminMapPage({Key? key}) : super(key: key);
  
  final FloatingActionButtonLocation fabLocation = FloatingActionButtonLocation.centerDocked;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(adminMapController);
    log("[AdminMapPage] reloaded");
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if(!controller.initialized){
        controller.initMap();
      }
      // if(controller.travelEnded){
      //   showAlertOptions(
      //     context,
      //     msg: "El conductor ha terminado el viaje",
      //     title: "Importante",
      //     closeOnPressed: () {
      //       Navigator.of(context).pop();
      //       Navigator.of(context).pop();
      //     },
      //   );
      // }
    });
    return PopScope(
      canPop: true,
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
            heroTag: 'heroAdminMap',
            onPressed: () => controller.showInfo(context),
            backgroundColor: const Color(0xFFddeaf4),
            child: const Icon(
              Icons.info,
              color: Color(0xFF3874c0),
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
        appBar: AppBar(
          automaticallyImplyLeading: true,
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const DecoratedIcon(
              icon: Icon(Icons.arrow_back, color: Color(0xFF3874c0), size: 30,),
              decoration: IconDecoration(
                border: IconBorder(
                  color: Colors.white,
                  width: 3
                )
              )
            ),
          ),
          title: const StrokeText(
            text: "Monitoreo de viajes",
            textStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 26,
              color: Color(0xFF3874c0),
            ),
            strokeColor: Colors.white,
            strokeWidth: 3,
          ),
          flexibleSpace: Image.asset(
            "assets/parte-top.png",
            fit: BoxFit.fitWidth,
            alignment: Alignment.topCenter,
          ),
        ),
      ),
    );
  }
}