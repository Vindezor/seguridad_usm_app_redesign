import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icon_decoration/icon_decoration.dart';
import 'package:stroke_text/stroke_text.dart';
import 'package:test_design/ui/administrate/stops/administrate_stops_controller.dart';
import 'package:test_design/ui/administrate/stops/widgets/stop_card.dart';

class AdministrateStopsPage extends ConsumerWidget {
  const AdministrateStopsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(administrateStopsController);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if(controller.stops == null){
        controller.getAllStops(context);
      }
    });
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child:  controller.stops != null && controller.stops!.isNotEmpty ? ListView(
          children: controller.stops!.map(
            (stop) => StopCard(
              id: stop.id,
              name: stop.name,
              coordinate: stop.coordinate,
            )
          ).toList(),
        ) : const Center(
          child: Text(
            "No hay paradas registradas",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
      ),
      floatingActionButton: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              color: Colors.black,
              spreadRadius: -5,
            )
          ]
        ),
        child: FloatingActionButton(
          onPressed: () => Navigator.of(context).pushNamed('/add_edit_stop').then((value) => controller.getAllStops(context)),
          backgroundColor: const Color(0xFFddeaf4),
          child: const Icon(Icons.add, color: Color(0xFF3874c0),),
        ),
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
          text: "Paradas",
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
    );
  }
}