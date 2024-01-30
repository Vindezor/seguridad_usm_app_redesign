import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_design/routes/routes.dart';
import 'package:test_design/ui/register/register_controller.dart';

class RegisterPage extends ConsumerWidget {
  const RegisterPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(registerController);
    log("[RegisterPage] reloaded");
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Image.asset(
                "assets/parte-top.png",
                fit: BoxFit.fitWidth,
                alignment: Alignment.topCenter,
              )
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Image.asset(
                "assets/background.png",
                fit: BoxFit.fitWidth,
                alignment: Alignment.bottomCenter,
              )
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                color: Colors.transparent
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Image(
                    image: AssetImage("assets/usm-logo.png"),
                    height: 100,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 50, right: 50, top: 40),
                    child: Text(
                      "Registrarse",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 50, right: 50, top: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: TextField(
                            onChanged:(_) => controller.codeChanged(),
                            focusNode: controller.codeFocusNode,
                            maxLength: 7,
                            controller: controller.codeController,
                            decoration: InputDecoration(
                              error: (controller.registerButtonDisabled() && controller.codeTouched) ? Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Text(
                                  "Campo inválido",
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    color: Theme.of(context).colorScheme.error,
                                    fontSize: 12
                                  ),
                                ),
                              ) : null,
                              filled: true,
                              fillColor: Colors.white,
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(25)),
                              ),
                              labelText: 'Código de carnet',
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, bottom: 25),
                          child: FloatingActionButton(
                            //elevation: 3,
                            //highlightElevation: 0,
                            onPressed: () {
                              Navigator.of(context).pop();
                              Navigator.of(context).pushNamed(Routes.register);
                              Navigator.of(context).pushNamed(Routes.registerQrScanner).then(
                                (value){
                                  if(value != null) controller.changeTextValue(value.toString());
                                }
                              );
                            },
                            backgroundColor: const Color(0xFFddeaf4),
                            child: const Icon(Icons.qr_code_scanner, color: Color(0xFF3874c0), size: 40, weight: 0.5,),
                          )
                        ),
                      ],
                    )
                  ),
                  // const Padding(
                  //   padding: EdgeInsets.only(left: 50, right: 50, top: 40),
                  //   child: TextField(
                  //     obscureText: true,
                  //     decoration: InputDecoration(
                  //       border: OutlineInputBorder(
                  //         borderRadius: BorderRadius.all(Radius.circular(25)),
                  //       ),
                  //       labelText: 'Contraseña',
                  //     ),
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.only(left: 90, right: 90, top: 40),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFe9f2f7),
                        elevation: 1,
                      ),
                      onPressed: controller.registerButtonDisabled() ? null : () => controller.register(context),
                      child: const Text(
                        "Registrarse",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}