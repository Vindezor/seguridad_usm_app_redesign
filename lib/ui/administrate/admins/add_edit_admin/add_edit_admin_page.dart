import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icon_decoration/icon_decoration.dart';
import 'package:stroke_text/stroke_text.dart';
import 'package:test_design/ui/administrate/admins/add_edit_admin/add_edit_admin_controller.dart';

class AddEditAdminPage extends ConsumerWidget {
  const AddEditAdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(addEditAdminController);
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
              ListView(
                // mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 50, right: 50, top: 20),
                    child: Text(
                      "Datos del administrador",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 50, right: 50, top: 20),
                    child: TextField(
                      focusNode: controller.fullNameFocusNode,
                      onChanged: (value) {
                        controller.changeInput();
                      },
                      keyboardType: TextInputType.name,
                      controller: controller.fullNameController,
                      textInputAction: TextInputAction.next,
                      maxLength: 50,
                      decoration: InputDecoration(
                        error: (controller.fullNameIsBad() && controller.fullNameTouched) ? Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: StrokeText(
                            text: "Campo inválido",
                            //textAlign: TextAlign.justify,
                            textStyle: TextStyle(
                              color: Theme.of(context).colorScheme.error,
                              fontSize: 12
                            ),
                            strokeColor: Colors.white,
                            strokeWidth: 3,
                          ),
                        ) : null,
                        filled: true,
                        fillColor: Colors.white,
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                        ),
                        labelText: 'Nombre Completo',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 50, right: 50, top: 20),
                    child: TextField(
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      focusNode: controller.documentFocusNode,
                      onChanged: (value) {
                        controller.changeInput();
                      },
                      keyboardType: TextInputType.number,
                      controller: controller.documentController,
                      textInputAction: TextInputAction.next,
                      maxLength: 9,
                      decoration: InputDecoration(
                        error: (controller.documentIsBad() && controller.documentTouched) ? Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: StrokeText(
                            text: "Campo inválido",
                            //textAlign: TextAlign.justify,
                            textStyle: TextStyle(
                              color: Theme.of(context).colorScheme.error,
                              fontSize: 12
                            ),
                            strokeColor: Colors.white,
                            strokeWidth: 3,
                          ),
                        ) : null,
                        filled: true,
                        fillColor: Colors.white,
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                        ),
                        labelText: 'Cédula',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 50, right: 50, top: 20),
                    child: TextField(
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      focusNode: controller.phoneFocusNode,
                      onChanged: (value) {
                        controller.changeInput();
                      },
                      keyboardType: TextInputType.phone,
                      controller: controller.phoneController,
                      textInputAction: TextInputAction.next,
                      maxLength: 11,
                      decoration: InputDecoration(
                        error: (controller.phoneIsBad() && controller.phoneTouched) ? Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: StrokeText(
                            text: "Campo inválido",
                            //textAlign: TextAlign.justify,
                            textStyle: TextStyle(
                              color: Theme.of(context).colorScheme.error,
                              fontSize: 12
                            ),
                            strokeColor: Colors.white,
                            strokeWidth: 3,
                          ),
                        ) : null,
                        filled: true,
                        fillColor: Colors.white,
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                        ),
                        labelText: 'Teléfono',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 50, right: 50, top: 20),
                    child: TextField(
                      focusNode: controller.emailFocusNode,
                      onChanged: (value) {
                        controller.changeInput();
                      },
                      keyboardType: TextInputType.text,
                      controller: controller.emailController,
                      textInputAction: TextInputAction.next,
                      maxLength: 50,
                      decoration: InputDecoration(
                        error: (controller.emailIsBad() && controller.emailTouched) ? Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: StrokeText(
                            text: "Campo inválido",
                            //textAlign: TextAlign.justify,
                            textStyle: TextStyle(
                              color: Theme.of(context).colorScheme.error,
                              fontSize: 12
                            ),
                            strokeColor: Colors.white,
                            strokeWidth: 3,
                          ),
                        ) : null,
                        filled: true,
                        fillColor: Colors.white,
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                        ),
                        labelText: 'Correo',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 90, right: 90, top: 20),
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
                  const SizedBox(height: 20,)
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
      //         blurRadius: 20,
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
      //       size: 20,
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
          text: controller.editing ? "Editar Admin" : "Añadir Admin",
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