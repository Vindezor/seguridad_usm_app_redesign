import 'package:flutter/material.dart';

class HistoryItem extends StatelessWidget {
  const HistoryItem({super.key});

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
        child: const Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Número de viaje: 545",
                  style: TextStyle(
                    color: Color(0xFF3874c0)
                  ),
                ),
                Text(
                  "Tiempo de viaje: 20:45",
                  style: TextStyle(
                    color: Color(0xFF3874c0)
                  ),
                ),
                Text(
                  "Número de incidentes: 0",
                  style: TextStyle(
                    color: Color(0xFF3874c0)
                  ),
                ),
                Text(
                  "Salida: La California",
                  style: TextStyle(
                    color: Color(0xFF3874c0)
                  ),
                ),
                Text(
                  "Destino: USM, La Florencia",
                  style: TextStyle(
                    color: Color(0xFF3874c0)
                  ),
                ),
              ],
            ),
            Column(
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