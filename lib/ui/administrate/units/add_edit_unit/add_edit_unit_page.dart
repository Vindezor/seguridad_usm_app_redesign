import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icon_decoration/icon_decoration.dart';
import 'package:stroke_text/stroke_text.dart';
import 'package:test_design/ui/administrate/units/add_edit_unit/add_edit_unit_controller.dart';

class AddEditUnitPage extends ConsumerWidget {
  const AddEditUnitPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(addEditUnitController);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if(!controller.checked){
        final args = ModalRoute.of(context)!.settings.arguments;
        controller.check(args, context);
      }
    });
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
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
              Scrollbar(
                controller: controller.scrollController,
                thumbVisibility: true,
                child: ListView(
                  controller: controller.scrollController,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 50, right: 50, top: 40),
                      child: Text(
                        "Datos de la unidad",
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
                        controller: controller.plateController,
                        textInputAction: TextInputAction.next,
                        // obscureText: true,
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                          ),
                          labelText: 'Placa',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 50, right: 50, top: 40),
                      child: TextField(
                        onChanged: (value) {
                          controller.changeName();
                        },
                        keyboardType: TextInputType.number,
                        controller: controller.yearController,
                        textInputAction: TextInputAction.next,
                        // obscureText: true,
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                          ),
                          labelText: 'Año',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 50, right: 50, top: 40),
                      child: TextField(
                        maxLines: 2,
                        onChanged: (value) {
                          controller.changeName();
                        },
                        keyboardType: TextInputType.name,
                        controller: controller.descriptionController,
                        textInputAction: TextInputAction.next,
                        // obscureText: true,
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                          ),
                          labelText: 'Descripción',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 50, right: 50, top: 40),
                      child: DropdownButtonFormField(
                        isExpanded: true,
                        items: controller.driverItems,
                        onChanged: controller.driverDropdownCallback,
                        value: controller.selectedDriver,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                          ),
                          label: Container(
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(30)),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.only(left: 5, right: 5),
                              child: Text("Conductor"),
                            ),
                          )
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 50, right: 50, top: 40),
                      child: DropdownButtonFormField(
                        isExpanded: true,
                        items: controller.brandItems,
                        onChanged: (value) async {
                          controller.brandDropdownCallback(value, context);
                        },
                        value: controller.selectedBrand,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                          ),
                          label: Container(
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(30)),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.only(left: 5, right: 5),
                              child: Text("Marca"),
                            ),
                          )
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 50, right: 50, top: 40),
                      child: DropdownButtonFormField(
                        isExpanded: true,
                        items: controller.modelItems,
                        onChanged: controller.modelDropdownCallback,
                        value: controller.selectedModel,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                          ),
                          label: Container(
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(30)),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.only(left: 5, right: 5),
                              child: Text("Modelo"),
                            ),
                          )
                        ),
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 50, right: 50, top: 40),
                    //   child: TextField(
                    //     canRequestFocus: false,
                    //     onTap: () {
                    //       FocusScope.of(context).unfocus();
                    //       Navigator.of(context).pushNamed('/stop_map').then((result) {
                    //         if(result != null) {
                    //           controller.changeCoordinates(result as LatLng);
                    //         }
                    //       });
                    //     },
                    //     readOnly: true,
                    //     onChanged: (value) {
                    //       //controller.changedInput();
                    //     },
                    //     keyboardType: TextInputType.number,
                    //     controller: controller.coordinateController,
                    //     textInputAction: TextInputAction.next,
                    //     // obscureText: true,
                    //     decoration: InputDecoration(
                    //       filled: true,
                    //       fillColor: Colors.white,
                    //       border: const OutlineInputBorder(
                    //         borderRadius: BorderRadius.all(Radius.circular(25)),
                    //       ),
                    //       labelText: controller.coordinateController.value.text != "" ? 'Coordenadas' : "Seleccionar Coordenadas",
                    //     ),
                    //   ),
                    // ),
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
                    SizedBox(height: 20,)
                  ],
                ),
              ),
            ],
          ),
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
        title: StrokeText(
          text: controller.editing ? "Editar Unidad": "Añadir Unidad",
          textStyle: const TextStyle(
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