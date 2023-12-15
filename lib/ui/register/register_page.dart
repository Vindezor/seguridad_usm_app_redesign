import 'package:flutter/material.dart';
import 'package:test_design/routes/routes.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/background.jpeg"),
              fit: BoxFit.cover
            )
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
                  "Registrarse",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 50, right: 50, top: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Expanded(
                      child: TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                          ),
                          labelText: 'Código de carnet',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: FloatingActionButton(
                        //elevation: 3,
                        //highlightElevation: 0,
                        onPressed: () => {
                          Navigator.of(context).pushNamed(Routes.registerQrScanner)
                        },
                        backgroundColor: const Color(0xFFddeaf4),
                        child: const Icon(Icons.qr_code_scanner, color: Color(0xFF3874c0), size: 40, weight: 0.5,),
                      )
                    ),
                  ],
                )
              ),
              // const Padding(
              //   padding: EdgeInsets.only(left: 50, right: 50, top: 40),
              //   child: TextField(
              //     obscureText: true,
              //     decoration: InputDecoration(
              //       border: OutlineInputBorder(
              //         borderRadius: BorderRadius.all(Radius.circular(25)),
              //       ),
              //       labelText: 'Contraseña',
              //     ),
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.only(left: 90, right: 90, top: 40),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFe9f2f7),
                    elevation: 1,
                  ),
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed('/register_successful');
                  },
                  child: const Text(
                    "Registrarse",
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
      ),
    );
  }
}