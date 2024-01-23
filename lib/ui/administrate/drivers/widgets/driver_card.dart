import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_design/models/login_model.dart';
import 'package:test_design/ui/administrate/drivers/administrate_drivers_controller.dart';

class DriverCard extends ConsumerWidget {
  const DriverCard({
    super.key,
    required this.driver,
  });
  final User driver;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(administrateDriversController);
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
                  "Nombre: ${driver.fullName}",
                  style: const TextStyle(
                    color: Color(0xFF3874c0)
                  ),
                ),
                Text(
                  "Documento: ${driver.document}",
                  style: const TextStyle(
                    color: Color(0xFF3874c0)
                  ),
                ),
                Text(
                  "Teléfono: ${driver.phone}",
                  style: const TextStyle(
                    color: Color(0xFF3874c0)
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () => Navigator.of(context).pushNamed('/add_edit_drive', arguments: {
                    "driver": driver.toJson()
                  }).then((result) {
                    controller.getAllDrivers(context);
                  }),
                  icon: const Icon(Icons.edit),
                  iconSize: 30,
                  color: const Color(0xFF3874c0),
                ),
                IconButton(
                  onPressed: () => controller.deleteDriver(context, driver.id),
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