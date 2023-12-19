import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:test_design/routes/routes.dart';
import 'package:test_design/ui/home/widgets/button_home.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    FloatingActionButtonLocation fabLocation = FloatingActionButtonLocation.centerDocked;

    return Scaffold(
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
                ButtonHome(
                  icon: Icons.settings,
                  text: "Ajustes",
                  onTap: (){
                    Navigator.of(context).pushNamed(Routes.settings);
                  },
                ),
                ButtonHome(
                  icon: Icons.menu_book,
                  text: "Guía",
                  onTap: (){
                    Navigator.of(context).pushNamed(Routes.guide);
                  },
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
          onPressed: () => {
            showDialog(
              context: context,
              builder: (context) => Dialog(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "QR para inciar ruta",
                        style: TextStyle(
                          color: Color(0xFF3874c0),
                          fontSize: 26,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      QrImageView(
                        data: "uioi-12312-5dasd-12c4d",
                        size: 200,
                        dataModuleStyle: const QrDataModuleStyle(dataModuleShape: QrDataModuleShape.square, color: Color(0xFF3874c0)),
                        eyeStyle: const QrEyeStyle(eyeShape: QrEyeShape.square, color: Color(0xFF3874c0)),
                      ),
                    ],
                  ),
                ),
              ),
            )
          },
          backgroundColor: const Color(0xFFddeaf4),
          child: const Icon(
            Icons.qr_code_scanner,
            color: Color(0xFF3874c0),
            size: 40,
            weight: 0.5,
          ),
        ),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.logout), iconSize: 30,)
        ],
        title: const Text(
          "Menú Principal",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 26,
            // shadows: [
            //   BoxShadow(
            //     color: Colors.black,
            //     blurRadius: 2,
            //     spreadRadius: 5,
            //     blurStyle: BlurStyle.outer
            //   )
            // ]
          ),
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
    );
  }
}