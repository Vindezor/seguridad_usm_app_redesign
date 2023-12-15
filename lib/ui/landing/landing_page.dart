import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background.png"),
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
              padding: EdgeInsets.only(left: 80, right: 80, top: 40),
              child: Text(
                "Bienvenidos a la aplicación de seguridad del transporte",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 80, right: 80, top: 40),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFFe9f2f7)),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                child: const Text(
                  "Iniciar sesión",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 80, right: 80, top: 20),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFFe9f2f7)),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
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
    );
  }
}