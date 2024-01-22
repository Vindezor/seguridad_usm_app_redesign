import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:icon_decoration/icon_decoration.dart';
import 'package:stroke_text/stroke_text.dart';
import 'package:test_design/ui/administrate/stops/add_edit_stop/add_edit_stop_controller.dart';

class AddEditStopPage extends ConsumerWidget {
  const AddEditStopPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(addEditStopController);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if(!controller.checked){
        final args = ModalRoute.of(context)!.settings.arguments;
        controller.check(args);
      }
    });
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          color: Colors.transparent
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Image.asset(
                "assets/background.png",
                fit: BoxFit.fitWidth,
                alignment: Alignment.bottomCenter,
              )
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 50, right: 50, top: 40),
                  child: Text(
                    "Datos de la parada",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 50, right: 50, top: 40),
                  child: TextField(
                    onChanged: (value) {
                      controller.changeName();
                    },
                    keyboardType: TextInputType.name,
                    controller: controller.nameController,
                    textInputAction: TextInputAction.next,
                    // obscureText: true,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                      ),
                      labelText: 'Nombre de la parada',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 50, right: 50, top: 40),
                  child: TextField(
                    canRequestFocus: false,
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      Navigator.of(context).pushNamed('/stop_map').then((result) {
                        if(result != null) {
                          controller.changeCoordinates(result as LatLng);
                        }
                      });
                    },
                    readOnly: true,
                    onChanged: (value) {
                      //controller.changedInput();
                    },
                    keyboardType: TextInputType.number,
                    controller: controller.coordinateController,
                    textInputAction: TextInputAction.next,
                    // obscureText: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                      ),
                      labelText: controller.coordinateController.value.text != "" ? 'Coordenadas' : "Seleccionar Coordenadas",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 90, right: 90, top: 40),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFFe9f2f7)),
                    ),
                    onPressed: controller.buttonDisabled() ? null : () => controller.save(context),
                    child: const Text(
                      "Guardar",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40,)
              ],
            ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => {},
      //   child: const Icon(Icons.add),
      // ),
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
          text: "Editar Parada",
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