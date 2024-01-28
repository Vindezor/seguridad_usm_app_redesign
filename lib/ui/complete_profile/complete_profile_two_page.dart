import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_design/ui/complete_profile/complete_profile_controller.dart';

class CompleteProfileTwoPage extends ConsumerWidget {
  const CompleteProfileTwoPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(completeProfileController);
    log("[CompleteProfileTwoPage] reloaded");
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
                          maxLength: 80,
                          focusNode: controller.emergencyEmailFocusNode,
                          onChanged: (value) {
                            controller.changedInput();
                          },
                          controller: controller.emergencyEmailController,
                          textInputAction: TextInputAction.next,
                          // obscureText: true,
                          decoration: InputDecoration(
                            error: (controller.emergencyEmailIsBad() && controller.emergencyEmailTouched) ? Padding(
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
                            labelText: 'Correo de Emergencia',
                          ),
                          onEditingComplete: () => FocusScope.of(context).requestFocus(controller.phoneFocusNode),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 50, right: 50, top: 40),
                        child: TextField(
                          keyboardType: TextInputType.number,
                          maxLength: 11,
                          focusNode: controller.phoneFocusNode,
                          onChanged: (value) {
                            controller.changedInput();
                          },
                          controller: controller.phoneController,
                          textInputAction: TextInputAction.next,
                          // obscureText: true,
                          decoration: InputDecoration(
                            error: (controller.phoneIsBad() && controller.phoneTouched) ? Padding(
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
                            labelText: 'Telefono',
                          ),
                          onEditingComplete: () => FocusScope.of(context).requestFocus(controller.emergencyPhoneFocusNode),
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 50, right: 50, top: 40),
                        child: TextField(
                          keyboardType: TextInputType.number,
                          maxLength: 11,
                          focusNode: controller.emergencyPhoneFocusNode,
                          onChanged: (value) {
                            controller.changedInput();
                          },
                          controller: controller.emergencyPhoneController,
                          textInputAction: TextInputAction.done,
                          // obscureText: true,
                          decoration: InputDecoration(
                            error: (controller.emergencyPhoneIsBad() && controller.emergencyPhoneTouched) ? Padding(
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
                            labelText: 'Telefono de Emergencia',
                          ),
                          // onEditingComplete: () {
                          //   if(controller.saveButtonDisabled()){
                          //     FocusScope.of(context).unfocus();
                          //   } else{
                          //     controller.save(context);
                          //   }
                          // },
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
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