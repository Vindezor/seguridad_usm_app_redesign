import 'package:flutter/material.dart';

class RegisterSuccessfulPage extends StatelessWidget {
  const RegisterSuccessfulPage({super.key});

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
                  "Se ha enviado un correo con su clave temporal al correo electrónico asociado en terna",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
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
                    Navigator.of(context).pushReplacementNamed('/login');
                  },
                  child: const Text(
                    "Iniciar Sesión",
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