import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_design/models/stops_model.dart';
import 'package:test_design/ui/administrate/routes/administrate_routes_controller.dart';

class RouteCard extends ConsumerWidget {
  const RouteCard({
    super.key,
    required this.id,
    required this.departure,
    required this.arrival,
  });
  final Stop departure;
  final Stop arrival;
  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(administrateRoutesController);
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFddeaf4),
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              blurRadius: 1,
              spreadRadius: -1
            )
          ]
        ),
        height: 120,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Salida: ${departure.name}",
                  style: const TextStyle(
                    color: Color(0xFF3874c0)
                  ),
                ),
                Text(
                  "Destino: ${arrival.name}",
                  style: const TextStyle(
                    color: Color(0xFF3874c0)
                  ),
                ),
                // Text(
                //   "Longitud: ${coordinate.split(",")[1]}",
                //   style: const TextStyle(
                //     color: Color(0xFF3874c0)
                //   ),
                // ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  // onPressed: () => Navigator.of(context).pushNamed('/add_edit_stop', arguments: {
                  //   "id": id,
                  //   "departure": departure.toJson(),
                  //   "arrival": arrival.toJson(),
                  // }).then((result) {
                  //   controller.getAllRoutes(context);
                  // }),
                  onPressed: () => controller.goToEditRoute(context, id, departure, arrival),
                  icon: const Icon(Icons.edit),
                  iconSize: 30,
                  color: const Color(0xFF3874c0),
                ),
                IconButton(
                  onPressed: () => controller.deleteRoute(context, id),
                  icon: const Icon(Icons.delete),
                  iconSize: 30,
                  color: const Color(0xFFb04d1e),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}