
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_design/models/travel_model.dart';
import 'package:test_design/ui/admin_map/travel_info/travel_info_controller.dart';

class TravelInfo extends ConsumerWidget {
  const TravelInfo({
    super.key,
    required this.selectedTravel,
  });

  final Travel selectedTravel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(travelInfoController);
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.72,
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              const Text(
                "Datos del viaje",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Color(0xFF3874c0)
                ),
              ),
              Text(
                "Fecha de inicio: ${selectedTravel.startTime.day}/${selectedTravel.startTime.month}/${selectedTravel.startTime.year}",
                style: const TextStyle(
                  color: Color(0xFF3874c0),
                  fontSize: 16,
                ),
              ),
              Text(
                "Hora de inicio: ${selectedTravel.startTime.hour}:${selectedTravel.startTime.minute}",
                style: const TextStyle(
                  color: Color(0xFF3874c0),
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 10,),
              const Text(
                "Datos de la ruta",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Color(0xFF3874c0)
                ),
              ),
              Text(
                "Salida: ${selectedTravel.route.departure.name}",
                style: const TextStyle(
                  color: Color(0xFF3874c0),
                  fontSize: 16,
                ),
              ),
              Text(
                "Destino: ${selectedTravel.route.arrival.name}",
                style: const TextStyle(
                  color: Color(0xFF3874c0),
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 10,),
              const Text(
                "Datos de la unidad",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Color(0xFF3874c0)
                ),
              ),
              Text(
                "Placa: ${selectedTravel.unit.plate}",
                style: const TextStyle(
                  color: Color(0xFF3874c0),
                  fontSize: 16,
                ),
              ),
              Text(
                "Año: ${selectedTravel.unit.year}",
                style: const TextStyle(
                  color: Color(0xFF3874c0),
                  fontSize: 16,
                ),
              ),
              Text(
                "Marca: ${selectedTravel.unit.model.brand.brand}",
                style: const TextStyle(
                  color: Color(0xFF3874c0),
                  fontSize: 16,
                ),
              ),
              Text(
                "Modelo: ${selectedTravel.unit.model.model}",
                style: const TextStyle(
                  color: Color(0xFF3874c0),
                  fontSize: 16,
                ),
              ),
              Text(
                "Descripción: ${selectedTravel.unit.description}",
                style: const TextStyle(
                  color: Color(0xFF3874c0),
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 10,),
              const Text(
                "Datos del conductor",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Color(0xFF3874c0)
                ),
              ),
              Text(
                "Nombre Completo: ${selectedTravel.unit.driver!.fullName}",
                style: const TextStyle(
                  color: Color(0xFF3874c0),
                  fontSize: 16,
                ),
              ),
              Text(
                "Cédula: ${selectedTravel.unit.driver!.document}",
                style: const TextStyle(
                  color: Color(0xFF3874c0),
                  fontSize: 16,
                ),
              ),
              Text(
                "Telefono: ${selectedTravel.unit.driver!.phone}",
                style: const TextStyle(
                  color: Color(0xFF3874c0),
                  fontSize: 16,
                ),
              ),
              Text(
                "Correo: ${selectedTravel.unit.driver!.email}",
                style: const TextStyle(
                  color: Color(0xFF3874c0),
                  fontSize: 16,
                ),
              ),
              Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFFe9f2f7)),
                    ),
                    onPressed: () => controller.goToAllPassengers(context, selectedTravel.id),
                    child: const Text(
                      "Ver pasajeros",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  selectedTravel.endTime == null ? const SizedBox(
                    width: 20,
                  ) : const SizedBox.shrink(),
                  selectedTravel.endTime == null ? ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFFefdbd2)),
                    ),
                    onPressed: () => controller.endTravel(context, selectedTravel.id),
                    child: const Text(
                      "Terminar viaje",
                      style: TextStyle(
                        color: Color(0xFFb04d1e),
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ) : const SizedBox.shrink(),
                ],
              ),
            )
            ],
          ),
        ),
      ),
    );
  }
}