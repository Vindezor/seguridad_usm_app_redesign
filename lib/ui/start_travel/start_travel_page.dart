import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icon_decoration/icon_decoration.dart';
import 'package:stroke_text/stroke_text.dart';
import 'package:test_design/ui/start_travel/start_travel_controller.dart';

class StartTravelPage extends ConsumerWidget {
  const StartTravelPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    log("[StartTravelPage] reloaded");
    final controller = ref.watch(startTravelController);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if(controller.items.isEmpty){
        log("${controller.items.isEmpty}");
        await controller.getAllRoutes(context);
      }
    });
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Image.asset(
              "assets/background.png",
              fit: BoxFit.fitWidth,
              alignment: Alignment.bottomCenter,
            )
          ),
          Container(
            decoration: const BoxDecoration(
              // image: DecorationImage(
              //   image: AssetImage("assets/background.png"),
              //   fit: BoxFit.cover
              // )
            ),
            child: controller.items.isEmpty ? const SizedBox() : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 50, right: 50, top: 40),
                    child: Text(
                      "Porfavor, elija una ruta para iniciar el ingreso de pasajeros",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  const SizedBox(height: 30,),
                  Padding(
                    padding: const EdgeInsets.only(left: 40, right: 40),
                    child: DropdownButtonFormField(
                      isExpanded: true,
                      items: controller.items,
                      onChanged: controller.dropdownCallback,
                      value: controller.dropdownValue,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                        ),
                        labelText: 'Ruta',
                      ),
                    ),
                  ),
                  // TextField(
                  //   controller: controller.departureController,
                    // decoration: const InputDecoration(
                    //   filled: true,
                    //   fillColor: Colors.white,
                    //   border: OutlineInputBorder(
                    //     borderRadius: BorderRadius.all(Radius.circular(25)),
                    //   ),
                    //   labelText: 'Salida',
                    // ),
                  // ),
                  // TextField(
                  //   controller: controller.arrivalController,
                  //   decoration: const InputDecoration(
                  //     filled: true,
                  //     fillColor: Colors.white,
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.all(Radius.circular(25)),
                  //     ),
                  //     labelText: 'Destino',
                  //   ),
                  // ),
                  const SizedBox(height: 60,),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFFe9f2f7)),
                    ),
                    onPressed: controller.startTravelButtonDisabled() ? null : () => controller.startTravel(context),
                    child: const Text(
                      "Comezar ingreso",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 120,),
                ],
              ),
            )
          ),
        ],
      ),
      // floatingActionButtonLocation: fabLocation,
      // floatingActionButton: Container(
      //   decoration: const BoxDecoration(
      //     boxShadow: [
      //       BoxShadow(
      //         blurRadius: 30,
      //         color: Colors.black,
      //         spreadRadius: -5,
      //       )
      //     ]
      //   ),
      //   child: FloatingActionButton.large(
      //     onPressed: () => {},
      //     backgroundColor: const Color(0xFFddeaf4),
      //     child: const Icon(
      //       Icons.qr_code_scanner,
      //       color: Color(0xFF3874c0),
      //       size: 40,
      //       weight: 0.5,
      //     ),
      //   ),
      // ),
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
          text: "Iniciar viaje",
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
      // bottomNavigationBar: const BottomAppBar(
      //   shape: CircularNotchedRectangle(),
      //   color: Color(0xFF3874c0),
      //   // child: Row(
      //   //   children: [
      //   //     IconButton(
      //   //       tooltip: 'Open navigation menu',
      //   //       icon: const Icon(Icons.menu, color: Colors.white,),
      //   //       onPressed: () {},
      //   //     ),
      //   //     IconButton(
      //   //       tooltip: 'Open navigation menu',
      //   //       icon: const Icon(Icons.menu, color: Colors.white,),
      //   //       onPressed: () {},
      //   //     ),
      //   //     const Spacer(),
      //   //     IconButton(
      //   //       tooltip: 'Open navigation menu',
      //   //       icon: const Icon(Icons.menu, color: Colors.white,),
      //   //       onPressed: () {},
      //   //     ),
      //   //     IconButton(
      //   //       tooltip: 'Open navigation menu',
      //   //       icon: const Icon(Icons.menu, color: Colors.white,),
      //   //       onPressed: () {},
      //   //     ),
      //   //   ],
      //   // ),
      // ),
    );
  }
}