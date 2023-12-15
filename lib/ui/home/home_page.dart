import 'package:flutter/material.dart';
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
          onPressed: () => {},
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
          "Estudiante",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 26,
          ),
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