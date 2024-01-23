import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icon_decoration/icon_decoration.dart';
import 'package:stroke_text/stroke_text.dart';
import 'package:test_design/ui/profile/profile_controller.dart';
import 'package:test_design/ui/profile/widgets/profile_data_card.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(profileController);
    WidgetsBinding.instance.addPostFrameCallback((_) => controller.initProfile(context));
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: Scrollbar(
        child: ListView(
          children: controller.ready ? [
            controller.fullName != null ? ProfileDataCard(
              title: "Nombre Completo",
              text: controller.fullName!,
            ) : const SizedBox.shrink(), 
            controller.document != null ? ProfileDataCard(
              title: "Cedula",
              text: controller.document!,
            ) : const SizedBox.shrink(),
            controller.email != null ? ProfileDataCard(
              title: "Correo",
              text: controller.email!,
            ) : const SizedBox.shrink(),
            controller.emergencyEmail != null ? ProfileDataCard(
              title: "Correo de Emergencia",
              text: controller.emergencyEmail!,
            ) : const SizedBox.shrink(),
            controller.phone != null ? ProfileDataCard(
              title: "Telefono",
              text: controller.phone!,
            ) : const SizedBox.shrink(),
            controller.emergencyPhone != null ? ProfileDataCard(
              title: "Telefono de Emergencia",
              text: controller.emergencyPhone!,
            ) : const SizedBox.shrink(),
            controller.universityCode != null ? ProfileDataCard(
              title: "Código de Carnet",
              text: controller.universityCode!,
            ) : const SizedBox.shrink(),
            controller.getExpirationDate() != null ? ProfileDataCard(
              title: "Fecha de Vencimiento",
              text: controller.getExpirationDate()!,
            ) : const SizedBox.shrink(),
            const SizedBox(
              height: 20,
            )
          ] : const [SizedBox()],
        ),
      ),
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
      floatingActionButton: controller.emergencyEmail != null ? FloatingActionButton(
        heroTag: 'heroProfile',
        onPressed: () => controller.goToEditProfile(context),
        backgroundColor: const Color(0xFF3874c0),
        child: const Icon(
          Icons.edit,
          color: Color(0xFFddeaf4),
        ),
      ) : null,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const DecoratedIcon(
            icon: Icon(
              Icons.arrow_back,
              color: Color(0xFF3874c0),
              size: 30,
            ),
            decoration: IconDecoration(
              border: IconBorder(
                color: Colors.white,
                width: 3
              )
            )
          ),
        ),
        title: const StrokeText(
          text: "Perfil",
          textStyle: TextStyle(
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
