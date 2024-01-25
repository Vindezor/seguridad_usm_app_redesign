import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stroke_text/stroke_text.dart';
import 'package:test_design/routes/routes.dart';
import 'package:test_design/ui/home/home_controller.dart';
import 'package:test_design/ui/home/widgets/button_home.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(homeController);

    FloatingActionButtonLocation fabLocation = FloatingActionButtonLocation.centerDocked;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if(controller.idTypeUser == null){
        controller.initProfile();
      }
    });
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          decoration: const BoxDecoration(
            // image: DecorationImage(
            //   image: AssetImage("assets/background.png"),
            //   fit: BoxFit.cover
            // )
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ButtonHome(
                    icon: Icons.person,
                    text: "Perfil",
                    onTap: (){
                      Navigator.of(context).pushNamed(Routes.profile);
                    },
                  ),
                  ButtonHome(
                    icon: Icons.date_range,
                    text: "Historial",
                    onTap: (){
                      Navigator.of(context).pushNamed(Routes.history);
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  (controller.idTypeUser != null) ? (controller.idTypeUser! < 3) ? ButtonHome(
                    icon: Icons.menu_book,
                    text: "Guía",
                    onTap: (){
                      Navigator.of(context).pushNamed(Routes.guide);
                    },
                  ) : ButtonHome(
                    icon: Icons.settings,
                    text: "Administrar",
                    onTap: (){
                      Navigator.of(context).pushNamed(Routes.administrate);
                    },
                  ) : const SizedBox.shrink(),
                  ButtonHome(
                    icon: Icons.logout,
                    text: "Cerrar Sesión",
                    onTap: () => controller.logout(context),
                  ),
                ],
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: fabLocation,
        floatingActionButton: Container(
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                blurRadius: 30,
                color: Colors.black,
                spreadRadius: -5,
              )
            ]
          ),
          child: FloatingActionButton.large(
            heroTag: 'heroHome',
            onPressed: () => controller.homeButton(context),
            backgroundColor: const Color(0xFFddeaf4),
            child: Icon(
              controller.idTypeUser == 3 ? Icons.map : controller.idTypeUser == 2 ? Icons.directions : Icons.qr_code_scanner,
              color: const Color(0xFF3874c0),
              size: 40,
              weight: 0.5,
            ),
          ),
        ),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          // actions: [
          //   IconButton(onPressed: () {}, icon: const Icon(Icons.logout), iconSize: 30,)
          // ],
          title: const StrokeText(
            text: "Menú Principal",
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
        bottomNavigationBar: const BottomAppBar(
          shape: CircularNotchedRectangle(),
          color: Color(0xFF3874c0),
          // child: Row(
          //   children: [
          //     IconButton(
          //       tooltip: 'Open navigation menu',
          //       icon: const Icon(Icons.menu, color: Colors.white,),
          //       onPressed: () {},
          //     ),
          //     IconButton(
          //       tooltip: 'Open navigation menu',
          //       icon: const Icon(Icons.menu, color: Colors.white,),
          //       onPressed: () {},
          //     ),
          //     const Spacer(),
          //     IconButton(
          //       tooltip: 'Open navigation menu',
          //       icon: const Icon(Icons.menu, color: Colors.white,),
          //       onPressed: () {},
          //     ),
          //     IconButton(
          //       tooltip: 'Open navigation menu',
          //       icon: const Icon(Icons.menu, color: Colors.white,),
          //       onPressed: () {},
          //     ),
          //   ],
          // ),
        ),
      ),
    );
  }
}