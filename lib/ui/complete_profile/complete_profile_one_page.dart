import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_design/ui/complete_profile/complete_profile_controller.dart';

class CompleteProfileOnePage extends ConsumerWidget {
  const CompleteProfileOnePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(completeProfileController);
    log("[CompleteProfileOnePage] reloaded");
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Colors.white,
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
                          "Establece una contraseña",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 50, right: 50, top: 40),
                        child: TextField(
                          controller: controller.passwordController,
                          textInputAction: TextInputAction.done,
                          obscureText: controller.hidePassword,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(25)),
                            ),
                            labelText: 'Contraseña',
                            suffixIcon: IconButton(
                              icon: controller.hidePassword ? const Icon(Icons.visibility) : const Icon(Icons.visibility_off),
                              onPressed: controller.onPressHidePassword,
                            )
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 50, right: 50, top: 40),
                        child: TextField(
                          controller: controller.confirmPasswordController,
                          textInputAction: TextInputAction.done,
                          obscureText: controller.hidePassword,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(25)),
                            ),
                            labelText: 'Confirmar Contraseña',
                            suffixIcon: IconButton(
                              icon: controller.hidePassword ? const Icon(Icons.visibility) : const Icon(Icons.visibility_off),
                              onPressed: controller.onPressHideConfirmPassword,
                            )
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 90, right: 90, top: 40),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFFe9f2f7)),
                          ),
                          onPressed: controller.nextButtonDisabled() ? null : () => controller.nextPage(context),
                          child: const Text(
                            "Siguiente",
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