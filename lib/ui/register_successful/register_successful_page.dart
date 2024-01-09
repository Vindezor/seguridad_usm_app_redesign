import 'package:flutter/material.dart';

class RegisterSuccessfulPage extends StatelessWidget {
  const RegisterSuccessfulPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Image.asset(
                  "assets/parte-top.png",
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.topCenter,
                )
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Image.asset(
                  "assets/background.png",
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.bottomCenter,
                )
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                  color: Colors.transparent
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
                        "¡Bienvenido/a a nuestra plataforma de seguridad de transporte! Tu usuario se ha creado exitosamente. Por favor, revisa tu correo electrónico institucional (Terna) para encontrar una clave temporal. Tienes 30 minutos para iniciar sesión en la plataforma, de lo contrario, tu cuenta será eliminada del sistema. ¡Gracias por elegirnos y viajar seguro!",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          
                        ),
                        textAlign: TextAlign.justify,
                      softWrap: true,
                      textWidthBasis: TextWidthBasis.parent,
                      

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
            ],
          ),
        ),
      ),
    );
  }
}