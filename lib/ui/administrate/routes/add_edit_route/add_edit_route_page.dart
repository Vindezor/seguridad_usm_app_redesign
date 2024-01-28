import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icon_decoration/icon_decoration.dart';
import 'package:stroke_text/stroke_text.dart';
import 'package:test_design/ui/administrate/routes/add_edit_route/add_edit_route_controller.dart';
import 'package:test_design/ui/administrate/routes/administrate_routes_controller.dart';

class AddEditRoutePage extends ConsumerWidget {
  const AddEditRoutePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(addEditRouteController);
    final administrateController = ref.watch(administrateRoutesController);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if(!controller.checked){
        final args = ModalRoute.of(context)!.settings.arguments;
        controller.check(args);
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
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 50, right: 50, top: 40),
                    child: Text(
                      "Datos de la ruta",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 50, right: 50, top: 40),
                    child: DropdownButtonFormField(
                      focusNode: controller.departureFocusNode,
                      isExpanded: true,
                      items: administrateController.selectDepartureItems,
                      onChanged: administrateController.departureDropdownCallback,
                      value: controller.editing ? administrateController.departureValue : null,
                      decoration: InputDecoration(
                        error: (administrateController.departureValue == null && controller.departureTouched) 
                        || (administrateController.departureValue != null && administrateController.arrivalValue != null
                        && administrateController.departureValue == administrateController.arrivalValue) ? Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Text(
                            (administrateController.departureValue != null && administrateController.arrivalValue != null
                            && administrateController.departureValue == administrateController.arrivalValue) 
                            ? "La ruta tiene que tener paradas diferentes" : "Campo inválido",
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.error,
                              fontSize: 12
                            ),
                          ),
                        ) : null,
                        hintText: "Seleccione un Salida",
                        filled: true,
                        fillColor: Colors.white,
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                        ),
                        labelText: 'Salida',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 50, right: 50, top: 40),
                    child: DropdownButtonFormField(
                      focusNode: controller.arrivalFocusNode,
                      isExpanded: true,
                      items: administrateController.selectArrivalItems,
                      onChanged: administrateController.arrivalDropdownCallback,
                      value: controller.editing ? administrateController.arrivalValue : null,
                      decoration: InputDecoration(
                        error: (administrateController.arrivalValue == null && controller.arrivalTouched)
                        || (administrateController.departureValue != null && administrateController.arrivalValue != null
                        && administrateController.departureValue == administrateController.arrivalValue) ? Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Text(
                            (administrateController.departureValue != null && administrateController.arrivalValue != null
                            && administrateController.departureValue == administrateController.arrivalValue) 
                            ? "La ruta tiene que tener paradas diferentes" : "Campo inválido",
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.error,
                              fontSize: 12
                            ),
                          ),
                        ) : null,
                        hintText: "Seleccione un Destino",
                        filled: true,
                        fillColor: Colors.white,
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                        ),
                        labelText: 'Destino',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 90, right: 90, top: 40),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFFe9f2f7)),
                      ),
                      onPressed: administrateController.generateRouteButtonDisabled() ? null : () => administrateController.generateRoute(context, controller.editing, id: controller.id),
                      child: const Text(
                        "Generar Ruta",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ],
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
          text: controller.editing ? "Editar Ruta" : "Añadir Ruta",
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