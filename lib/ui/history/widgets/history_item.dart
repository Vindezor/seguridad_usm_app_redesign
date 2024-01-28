import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_design/global/time_format.dart';
import 'package:test_design/models/travel_model.dart';
import 'package:test_design/ui/history/history_controller.dart';

class HistoryItem extends ConsumerWidget {
  const HistoryItem({
    super.key,
    required this.travel,
  });

  final Travel travel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(historyController);
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
                  "Duración: ${formatDuration(travel.startTime, travel.endTime!)}",
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
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () => { controller.showInfo(context, travel) },
                  icon: const Icon(Icons.info, size: 40, color: Color(0xFF3874c0),)
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}