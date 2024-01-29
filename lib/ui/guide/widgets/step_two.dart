import 'package:flutter/material.dart';

class StepTwo extends StatelessWidget {
  const StepTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Image.asset(
            "assets/parte-top.png",
            fit: BoxFit.fitWidth,
            alignment: Alignment.topCenter,
          )
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            color: Colors.transparent
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Paso 2",
                  style: TextStyle(
                    color: Color(0xFF3874c0),
                    fontSize: 32,
                    fontWeight: FontWeight.bold
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Image.asset("assets/tutorial-2.png", height: 200),
                const SizedBox(
                  height: 50,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                  child: Text(
                    "Una vez iniciada la ruta te saldra un mapa y debajo tendras un boton de emergencia que podras presionar si ocurre cualquier incidente que te ponga en peligro",
                    style: TextStyle(
                      color: Color(0xFF3874c0),
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}