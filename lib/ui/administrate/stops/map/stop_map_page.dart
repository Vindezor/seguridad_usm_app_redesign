import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:icon_decoration/icon_decoration.dart';
import 'package:stroke_text/stroke_text.dart';
import 'package:test_design/ui/administrate/stops/map/stop_map_controller.dart';

class StopMapPage extends ConsumerWidget {
  const StopMapPage({super.key});

  final FloatingActionButtonLocation fabLocation = FloatingActionButtonLocation.centerDocked;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(stopMapController);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if(!controller.initialized){
        final args =  ModalRoute.of(context)!.settings.arguments;
        controller.checkInit(args);
      }
    });
    return PopScope(
      canPop: true,
      child: Scaffold(
        body: GoogleMap(
          mapToolbarEnabled: false,
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          compassEnabled: false,
          mapType: MapType.normal,
          initialCameraPosition: controller.initialCameraPosition,
          onMapCreated: controller.onMapCreated,
          markers: controller.marker != null ? {
              controller.marker!
          } : {},
          onTap: (pos) => controller.setMarker(pos),
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
            text: "Selección de Parada",
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
            heroTag: 'heroStopMap',
            onPressed: controller.marker != null ? () => controller.confirm(context) : null,
            backgroundColor: controller.marker != null ? const Color(0xFFddeaf4) : const Color(0xFFe3e3e4),
            child: Icon(
              Icons.check,
              color: controller.marker != null ? const Color(0xFF3874c0) : const Color(0xFF9b9b9c),
              size: 40,
              weight: 0.5,
            ),
          ),
        ),
        bottomNavigationBar: const BottomAppBar(
          shape: CircularNotchedRectangle(),
          color: Color(0xFF3874c0),
        ),
      ),
    );
  }
}