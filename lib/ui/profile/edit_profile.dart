import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_design/ui/profile/profile_controller.dart';
import 'package:test_design/ui/profile/widgets/edit_profile_item.dart';

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
            EditProfileItem(
              title: 'Correo de Emergencia',
              controller: controller.emergencyEmailController,
              focusNode: controller.emergencyEmailFocusNode,
            ),
            EditProfileItem(
              title: 'Teléfono',
              controller: controller.phoneController,
              focusNode: controller.phoneFocusNode,
            ),
            EditProfileItem(
              title: 'Teléfono de Emergencia',
              controller: controller.emergencyPhoneController,
              focusNode: controller.emergencyPhoneFocusNode,
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
                    onPressed: () => controller.save(context),
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