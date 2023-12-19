import 'package:flutter/material.dart';
import 'package:test_design/ui/profile/widgets/edit_profil_item.dart';
import 'package:test_design/ui/profile/widgets/profile_data_card.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    //FloatingActionButtonLocation fabLocation = FloatingActionButtonLocation.centerDocked;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        decoration: const BoxDecoration(
          // image: DecorationImage(
          //   image: AssetImage("assets/background.png"),
          //   fit: BoxFit.cover
          // )
        ),
        child: ListView(
          children: [
            const ProfileDataCard(title: "Correo", text: "ejemplocorreo13@gmail.com"),
            const ProfileDataCard(title: "Correo de Emergencia", text: "ejemplocorreo2@gmail.com"),
            const ProfileDataCard(title: "Cedula", text: "C.I. 28.301.100"),
            Padding(
              padding: const EdgeInsets.only(left: 80, right: 80, top: 20),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFFe9f2f7)),
                ),
                onPressed: () {
                  showModalBottomSheet(
                    showDragHandle: true,
                    context: context,
                    isScrollControlled: true,
                    builder: (context) {
                      // return SizedBox(
                      //   height: 400,
                      //   child: Center(
                      //     child: ElevatedButton(
                      //       onPressed: () {
                      //         Navigator.pop(context);
                      //       },
                      //       child: const Text("a")
                      //     ),
                      //   ),
                      // );
                      return SingleChildScrollView(
                        child: Container(
                          height: 400,
                          padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom
                          ),
                          child: ListView(
                            children: [
                              const EditProfileItem(title: 'Correo'),
                              const EditProfileItem(title: 'Correo de Emergencia'),
                              const EditProfileItem(title: 'Cedula'),
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFFe9f2f7)),
                                      ),
                                      onPressed: () {
                                      },
                                      child: const Text(
                                        "Guardar",
                                        style: TextStyle(
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
                                        backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFFefdbd2)),
                                      ),
                                      onPressed: () {
                                      },
                                      child: const Text(
                                        "Cancelar",
                                        style: TextStyle(
                                          color: Color(0xFFb04d1e),
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
                  );
                },
                child: const Text(
                  "Editar",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
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
          "Perfil",
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