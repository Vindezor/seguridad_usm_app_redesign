import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_design/ui/profile/profile_controller.dart';

class EditProfile extends ConsumerWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(profileController);
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.7,
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: TextField(
                onChanged: (_) => controller.changeInput(),
                maxLength: 50,
                focusNode: controller.emergencyEmailFocusNode,
                controller: controller.emergencyEmailController,
                textInputAction: TextInputAction.done,
                obscureText: false,
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
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                  ),
                  labelText: "Correo de Emergencia",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: TextField(
                onChanged: (_) => controller.changeInput(),
                maxLength: 11,
                focusNode: controller.phoneFocusNode,
                controller: controller.phoneController,
                textInputAction: TextInputAction.done,
                obscureText: false,
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
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                  ),
                  labelText: "Teléfono",
                ),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: TextField(
                onChanged: (_) => controller.changeInput(),
                maxLength: 11,
                focusNode: controller.emergencyPhoneFocusNode,
                controller: controller.emergencyPhoneController,
                textInputAction: TextInputAction.done,
                obscureText: false,
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
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                  ),
                  labelText: "Teléfono de Emergencia",
                ),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFFefdbd2)),
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text(
                      "Cancelar",
                      style: TextStyle(
                        color: Color(0xFFb04d1e),
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFFe9f2f7)),
                    ),
                    onPressed: controller.saveButtonDisabled() ? null : () => controller.save(context),
                    child: const Text(
                      "Guardar",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      )
    );
  }
}