import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_design/global/time_format.dart';
import 'package:test_design/models/alerts_model.dart';

class AlertCard extends ConsumerWidget {
  const AlertCard({
    super.key,
    required this.alert
  });
  final Alert alert;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
        height: 150,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width *0.8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Fecha: ${alert.time.day}/${alert.time.month}/${alert.time.year}",
                    style: const TextStyle(
                      color: Color(0xFF3874c0)
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "Hora: ${formatHour(alert.time)}",
                    style: const TextStyle(
                      color: Color(0xFF3874c0),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "Nombre Completo: ${alert.user.fullName}",
                    style: const TextStyle(
                      color: Color(0xFF3874c0)
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "Cédula: ${alert.user.document}",
                    style: const TextStyle(
                      color: Color(0xFF3874c0)
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "Teléfono: ${alert.user.phone}",
                    style: const TextStyle(
                      color: Color(0xFF3874c0)
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "Correo: ${alert.user.email}",
                    style: const TextStyle(
                      color: Color(0xFF3874c0)
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}