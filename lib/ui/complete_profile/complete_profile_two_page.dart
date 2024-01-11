import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_design/ui/complete_profile/complete_profile_controller.dart';

class CompleteProfileTwoPage extends ConsumerWidget {
  const CompleteProfileTwoPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(completeProfileController);
    log("[CompleteProfileOnePage] reloaded");
    return PopScope(
      canPop: true,
      child: Scaffold(
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
                          "Completa tu perfil",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 50, right: 50, top: 40),
                        child: TextField(
                          onChanged: (value) {
                            controller.changedInput();
                          },
                          controller: controller.emergencyEmailController,
                          textInputAction: TextInputAction.next,
                          // obscureText: true,
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(25)),
                            ),
                            labelText: 'Correo de Emergencia',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 50, right: 50, top: 40),
                        child: TextField(
                          onChanged: (value) {
                            controller.changedInput();
                          },
                          controller: controller.phoneController,
                          textInputAction: TextInputAction.next,
                          // obscureText: true,
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(25)),
                            ),
                            labelText: 'Telefono',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 50, right: 50, top: 40),
                        child: TextField(
                          onChanged: (value) {
                            controller.changedInput();
                          },
                          controller: controller.emergencyPhoneController,
                          textInputAction: TextInputAction.next,
                          // obscureText: true,
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(25)),
                            ),
                            labelText: 'Telefono de Emergencia',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 90, right: 90, top: 40),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFFe9f2f7)),
                          ),
                          onPressed: controller.saveButtonDisabled() ? null : () => controller.save(context),
                          child: const Text(
                            "Guardar",
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
      ),
    );
  }
}