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
                          maxLength: 15,
                          focusNode: controller.passwordFocusNode,
                          onChanged: (value) {
                            controller.changedInput();
                          },
                          controller: controller.passwordController,
                          textInputAction: TextInputAction.next,
                          obscureText: controller.hidePassword,
                          decoration: InputDecoration(
                            error: (controller.passwordIsBad() && controller.passwordTouched) ? Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Text(
                                controller.passwordTooltip,
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
                            labelText: 'Contraseña',
                            suffixIcon: IconButton(
                              icon: controller.hidePassword ? const Icon(Icons.visibility) : const Icon(Icons.visibility_off),
                              onPressed: controller.onPressHidePassword,
                            )
                          ),
                          onEditingComplete: () => FocusScope.of(context).requestFocus(controller.confirmPasswordFocusNode),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 50, right: 50, top: 40),
                        child: TextField(
                          maxLength: 15,
                          focusNode: controller.confirmPasswordFocusNode,
                          onChanged: (value) {
                            controller.changedInput();
                          },
                          controller: controller.confirmPasswordController,
                          textInputAction: TextInputAction.done,
                          obscureText: controller.hideConfirmPassword,
                          decoration: InputDecoration(
                            error: (controller.confirmPasswordIsBad() && controller.confirmPasswordTouched) ? Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Text(
                                "Contraseñas deben coincidir",
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
                            labelText: 'Confirmar Contraseña',
                            suffixIcon: IconButton(
                              icon: controller.hideConfirmPassword ? const Icon(Icons.visibility) : const Icon(Icons.visibility_off),
                              onPressed: controller.onPressHideConfirmPassword,
                            ),
                          ),
                          // onEditingComplete: () {
                          //   if(controller.nextButtonDisabled()){
                          //     FocusScope.of(context).unfocus();
                          //   } else{
                          //     controller.nextPage(context);
                          //   }
                          // },
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