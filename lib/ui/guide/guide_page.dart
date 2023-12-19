import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:test_design/ui/guide/widgets/how-to-use.dart';
import 'package:test_design/ui/guide/widgets/step_one.dart';
import 'package:test_design/ui/guide/widgets/step_three.dart';
import 'package:test_design/ui/guide/widgets/step_two.dart';

class GuidePage extends StatelessWidget {
  const GuidePage({super.key});

  @override
  Widget build(BuildContext context) {
    //FloatingActionButtonLocation fabLocation = FloatingActionButtonLocation.centerDocked;
    return IntroSlider(
      listCustomTabs: const [
        HowToUse(),
        StepOne(),
        StepTwo(),
        StepThree(),
      ],
      renderDoneBtn: const Icon(
        Icons.done,
        size: 32,
      ),
      renderNextBtn: const Icon(
        Icons.navigate_next,
        size: 32,
      ),
      renderPrevBtn: const Icon(
        Icons.navigate_before,
        size: 32,
      ),
      isShowPrevBtn: true,
      isShowSkipBtn: false,
      backgroundColorAllTabs: Colors.white,
      // listContentConfig: const [
      //   ContentConfig(
      //     title: 'Paso 1',
      //     styleTitle: TextStyle(
      //       color: Color(0xFF3874c0),
      //       fontSize: 32,
      //       fontWeight: FontWeight.bold
      //     ),
      //     description: 'En el menu principal hay un boton abajo que al ser presionado saldrá un codigo QR que el colector del bus va a escanear e iniciará tu ruta',
      //     styleDescription: TextStyle(
      //       color: Color(0xFF3874c0),
      //       fontSize: 20,
      //     ),
      //     textAlignDescription: TextAlign.justify,
      //     pathImage: "assets/tutorial-1.png"
      //   ),
      //   ContentConfig(
      //     title: 'PruebB',
      //     styleTitle: TextStyle(
      //       color: Color(0xFF3874c0),
      //       fontSize: 32,
      //       fontWeight: FontWeight.bold
      //     ),
      //   ),
      //   ContentConfig(
      //     title: 'PruebC',
      //     styleTitle: TextStyle(
      //       color: Color(0xFF3874c0),
      //       fontSize: 32,
      //       fontWeight: FontWeight.bold
      //     ),
      //   )
      // ],
      onDonePress: () {
        Navigator.of(context).pop();
      },
    );
    // return Scaffold(
    //   body: Container(
    //     decoration: const BoxDecoration(
    //       // image: DecorationImage(
    //       //   image: AssetImage("assets/background.png"),
    //       //   fit: BoxFit.cover
    //       // )
    //     ),
    //     child: Container()
    //   ),
    //   // floatingActionButtonLocation: fabLocation,
    //   // floatingActionButton: Container(
    //   //   decoration: const BoxDecoration(
    //   //     boxShadow: [
    //   //       BoxShadow(
    //   //         blurRadius: 30,
    //   //         color: Colors.black,
    //   //         spreadRadius: -5,
    //   //       )
    //   //     ]
    //   //   ),
    //   //   child: FloatingActionButton.large(
    //   //     onPressed: () => {},
    //   //     backgroundColor: const Color(0xFFddeaf4),
    //   //     child: const Icon(
    //   //       Icons.qr_code_scanner,
    //   //       color: Color(0xFF3874c0),
    //   //       size: 40,
    //   //       weight: 0.5,
    //   //     ),
    //   //   ),
    //   // ),
    //   appBar: AppBar(
    //     automaticallyImplyLeading: true,
    //     actions: [
    //       IconButton(onPressed: () {}, icon: const Icon(Icons.logout), iconSize: 30,)
    //     ],
    //     title: const Text(
    //       "Guía",
    //       style: TextStyle(
    //         fontWeight: FontWeight.bold,
    //         fontSize: 26,
    //       ),
    //     ),
    //     flexibleSpace: Image.asset(
    //       "assets/parte-top.png",
    //       fit: BoxFit.fitWidth,
    //       alignment: Alignment.topCenter,
    //     ),
    //   ),
    //   // bottomNavigationBar: const BottomAppBar(
    //   //   shape: CircularNotchedRectangle(),
    //   //   color: Color(0xFF3874c0),
    //   //   // child: Row(
    //   //   //   children: [
    //   //   //     IconButton(
    //   //   //       tooltip: 'Open navigation menu',
    //   //   //       icon: const Icon(Icons.menu, color: Colors.white,),
    //   //   //       onPressed: () {},
    //   //   //     ),
    //   //   //     IconButton(
    //   //   //       tooltip: 'Open navigation menu',
    //   //   //       icon: const Icon(Icons.menu, color: Colors.white,),
    //   //   //       onPressed: () {},
    //   //   //     ),
    //   //   //     const Spacer(),
    //   //   //     IconButton(
    //   //   //       tooltip: 'Open navigation menu',
    //   //   //       icon: const Icon(Icons.menu, color: Colors.white,),
    //   //   //       onPressed: () {},
    //   //   //     ),
    //   //   //     IconButton(
    //   //   //       tooltip: 'Open navigation menu',
    //   //   //       icon: const Icon(Icons.menu, color: Colors.white,),
    //   //   //       onPressed: () {},
    //   //   //     ),
    //   //   //   ],
    //   //   // ),
    //   // ),
    // );
  }
}