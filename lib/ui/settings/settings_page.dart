import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
 // final AnimationController? controller = AnimationController(vsync: );
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    //FloatingActionButtonLocation fabLocation = FloatingActionButtonLocation.centerDocked;
    
    return Scaffold(
      // bottomSheet: BottomSheet(
      //     onClosing: () => {},
      //     builder: (context) {
      //       return Container(
      //         child: Text("data"),
      //       );
      //     }),
      body: Container(
        decoration: const BoxDecoration(
          // image: DecorationImage(
          //   image: AssetImage("assets/background.png"),
          //   fit: BoxFit.cover
          // )
        ),
        child: Center(
          child: ElevatedButton(
            onPressed: () {
              showModalBottomSheet(
                showDragHandle: true,
                context: context,
                builder: (context) {
                  return SizedBox(
                    height: 400,
                    child: Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("a")
                      ),
                    ),
                  );
                }
              );
            },
            child: const Text("a")
          ),
        )
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
      appBar: AppBar(
        automaticallyImplyLeading: true,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.logout), iconSize: 30,)
        ],
        title: const Text(
          "Ajustes",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 26,
          ),
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