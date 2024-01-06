import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_design/ui/login/login_controller.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(loginController);
    log("[LoginPage] reloaded");
    return Scaffold(
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
                      "Iniciar sesión",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 50, right: 50, top: 40),
                    child: TextField(
                      controller: controller.documentController,
                      textInputAction: TextInputAction.next,
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                        ),
                        labelText: 'Cédula',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 50, right: 50, top: 40),
                    child: TextField(
                      controller: controller.passwordController,
                      textInputAction: TextInputAction.done,
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                        ),
                        labelText: 'Contraseña',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 90, right: 90, top: 40),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFFe9f2f7)),
                      ),
                      onPressed: controller.loginButtonDisabled() ? null : () => controller.login(context),
                      child: const Text(
                        "Iniciar sesión",
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
        
        // Container(
        //   width: MediaQuery.of(context).size.width,
        //   height: MediaQuery.of(context).size.height,
        //   decoration: const BoxDecoration(
        //     image: DecorationImage(
        //       image: AssetImage("assets/background.png"),
        //       fit: BoxFit.cover
        //     )
        //   ),
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     crossAxisAlignment: CrossAxisAlignment.stretch,
        //     children: [
        //       const Image(
        //         image: AssetImage("assets/usm-logo.png"),
        //         height: 100,
        //       ),
        //       const Padding(
        //         padding: EdgeInsets.only(left: 50, right: 50, top: 40),
        //         child: Text(
        //           "Iniciar sesión",
        //           style: TextStyle(
        //             fontWeight: FontWeight.bold,
        //             fontSize: 18,
        //           ),
        //         ),
        //       ),
        //       const Padding(
        //         padding: EdgeInsets.only(left: 50, right: 50, top: 40),
        //         child: TextField(
        //           textInputAction: TextInputAction.next,
        //           obscureText: true,
        //           decoration: InputDecoration(
        //             border: OutlineInputBorder(
        //               borderRadius: BorderRadius.all(Radius.circular(25)),
        //             ),
        //             labelText: 'Cédula',
        //           ),
        //         ),
        //       ),
        //       const Padding(
        //         padding: EdgeInsets.only(left: 50, right: 50, top: 40),
        //         child: TextField(
        //           textInputAction: TextInputAction.done,
        //           obscureText: true,
        //           decoration: InputDecoration(
        //             border: OutlineInputBorder(
        //               borderRadius: BorderRadius.all(Radius.circular(25)),
        //             ),
        //             labelText: 'Contraseña',
        //           ),
        //         ),
        //       ),
        //       Padding(
        //         padding: const EdgeInsets.only(left: 90, right: 90, top: 40),
        //         child: ElevatedButton(
        //           style: ButtonStyle(
        //             backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFFe9f2f7)),
        //           ),
        //           onPressed: () {
        //             Navigator.of(context).pushNamed('/home');
        //           },
        //           child: const Text(
        //             "Iniciar sesión",
        //             style: TextStyle(
        //               fontWeight: FontWeight.bold,
        //               fontSize: 15,
        //             ),
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
      ),
    );
  }
}