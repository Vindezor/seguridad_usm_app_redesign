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
    });
    return PopScope(
      canPop: true,
      child: Scaffold(
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
            onPressed: controller.selectedTravel != null ? () => controller.showInfo(context) : null,
            backgroundColor: controller.selectedTravel != null ? const Color(0xFFddeaf4) : const Color(0xFFe3e3e4),
            child: Icon(
              Icons.info,
              color: controller.selectedTravel != null ? const Color(0xFF3874c0) : const Color(0xFF9b9b9c),
              size: 40,
              weight: 0.5,
            ),
          ),
        ),
        bottomNavigationBar: const BottomAppBar(
          shape: CircularNotchedRectangle(),
          color: Color(0xFF3874c0),
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