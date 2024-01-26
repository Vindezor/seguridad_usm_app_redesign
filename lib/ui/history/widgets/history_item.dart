import 'package:flutter/material.dart';
import 'package:test_design/models/travel_model.dart';

class HistoryItem extends StatelessWidget {
  const HistoryItem({
    super.key,
    required this.travel,
  });

  final Travel travel;

  @override
  Widget build(BuildContext context) {
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
                  "Fecha: ${travel.startTime.day}/${travel.startTime.month}/${travel.startTime.year}",
                  style: const TextStyle(
                    color: Color(0xFF3874c0)
                  ),
                ),
                Text(
                  "Salida: ${travel.route.departure.name}",
                  style: const TextStyle(
                    color: Color(0xFF3874c0)
                  ),
                ),
                Text(
                  "Destino: ${travel.route.arrival.name}",
                  style: const TextStyle(
                    color: Color(0xFF3874c0)
                  ),
                ),
                travel.endTime != null ? Text(
                  "Duración: ${travel.endTime!.difference(travel.startTime).inMinutes}:${travel.endTime!.difference(travel.startTime).inSeconds}",
                  style: const  TextStyle(
                    color: Color(0xFF3874c0)
                  ),
                ) : const SizedBox.shrink(),
                // Text(
                //   "Destino: USM, La Florencia",
                //   style: TextStyle(
                //     color: Color(0xFF3874c0)
                //   ),
                // ),
              ],
            ),
            const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.qr_code_2, size: 80, color: Color(0xFF3874c0),)
              ],
            )
          ],
        ),
      ),
    );
  }
}