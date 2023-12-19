import 'package:flutter/material.dart';

class HowToUse extends StatelessWidget {
  const HowToUse({super.key});

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
          child: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "¿Cómo usar la aplicación?",
                  style: TextStyle(
                    color: Color(0xFF3874c0),
                    fontSize: 32,
                    fontWeight: FontWeight.bold
                  ),
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20, right: 20, top: 50),
                  child: Text(
                    "Es fácil, lo aprenderás en esta guía, desliza a la derecha o presiona la flecha para continuar",
                    style: TextStyle(
                      color: Color(0xFF3874c0),
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.only(top: 50),
                //   child:ElevatedButton(
                //     style: ButtonStyle(
                //       backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFFe9f2f7)),
                //     ),
                //     onPressed: () {
                //       //Navigator.of(context).pushNamed('/home');
                //     },
                //     child: const Text(
                //       "Comenzar",
                //       style: TextStyle(
                //         fontWeight: FontWeight.bold,
                //         fontSize: 15,
                //       ),
                //     ),
                //   ),
                // )
              ],
            ),
          ),
        )
      ],
    );
  }
}