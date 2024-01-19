import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_design/global/global_loading.dart';

class StartTravelController extends ChangeNotifier{
  
  StartTravelController(){
    log("[StartTravelController] init");
  }

  //int value;
  final TextEditingController departureController = TextEditingController();
  final TextEditingController arrivalController = TextEditingController();

  //final UserService userService = UserService(Dio());

  void startTravel(context) async {
    globalLoading(context);
    Navigator.of(context).pop();
    // final GenericModel? response = await userService.register(university_code: textEditingController.value.text);
    // if(response != null){
    //   Navigator.of(context).pop();
    //   if(response.status == "SUCCESS"){
    //     Navigator.pushReplacementNamed(context, '/register_successful');
    //     // showAlertOptions(
    //     //   context,
    //     //   msg: "¡Bienvenido/a a nuestra plataforma de seguridad de transporte! Tu usuario se ha creado exitosamente. Por favor, revisa tu correo electrónico institucional (Terna) para encontrar una clave temporal. Tienes 30 minutos para iniciar sesión en la plataforma, de lo contrario, tu cuenta será eliminada del sistema. ¡Gracias por elegirnos y viajar seguro!",
    //     //   title: "Importante",
    //     //   justified: true,
    //     //   closeOnPressed: () {
    //     //     Navigator.of(context).pop();
    //     //     Navigator
    //     //   },
    //     // );
    //   } else {
    //     showAlertOptions(
    //       context,
    //       msg: response.msg,
    //       title: "Importante"
    //     );
    //   }
    // } else {
    //   Navigator.of(context).pop();
    //   showAlertOptions(
    //     context,
    //     msg: "Ha ocurrido un error con el servicio. Intente mas tarde",
    //     title: "Importante"
    //   );
    // }
    //notifyListeners();
  }

  bool startTravelButtonDisabled(){
    // if(regex.hasMatch(textEditingController.value.text)){
    //   return false;
    // }
    // return true;
    return false;
  }

  // void changeTextValue(String text){
  //   textEditingController.text = text;
  //   notifyListeners();
  // }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    departureController.dispose();
    arrivalController.dispose();
    log("[StartTravelController] disposed");
  }
}

final startTravelController = ChangeNotifierProvider.autoDispose((_) => StartTravelController());