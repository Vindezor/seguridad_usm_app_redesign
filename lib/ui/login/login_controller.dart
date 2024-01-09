import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_design/global/global_dialog.dart';
import 'package:test_design/global/global_loading.dart';
import 'package:test_design/models/login_model.dart';
import 'package:test_design/services/user_service.dart';

class LoginController extends ChangeNotifier{
  
  LoginController(){
    log("[LoginController] init");
  }

  //int value;
  final TextEditingController documentController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final UserService userService = UserService(Dio());
  final documentRegex = RegExp(r'^\d{5,9}$');
  final passwordRegex = RegExp(r'^[A-Za-z\d.,_\-@*#$]{8,15}$');
  bool hidePassword = true;

  onPressHide(){
    hidePassword = !hidePassword;
    notifyListeners();
  }

  void login(context) async {
    globalLoading(context);
    final LoginModel? response = await userService.login(document: documentController.value.text, password: passwordController.value.text);
    if(response != null){
      Navigator.of(context).pop();
      if(response.status == "SUCCESS"){
        Navigator.pushReplacementNamed(context, '/home');
        // showAlertOptions(
        //   context,
        //   msg: "¡Bienvenido/a a nuestra plataforma de seguridad de transporte! Tu usuario se ha creado exitosamente. Por favor, revisa tu correo electrónico institucional (Terna) para encontrar una clave temporal. Tienes 30 minutos para iniciar sesión en la plataforma, de lo contrario, tu cuenta será eliminada del sistema. ¡Gracias por elegirnos y viajar seguro!",
        //   title: "Importante",
        //   justified: true,
        //   closeOnPressed: () {
        //     Navigator.of(context).pop();
        //     Navigator
        //   },
        // );
      } else {
        showAlertOptions(
          context,
          msg: response.msg,
          title: "Importante"
        );
      }
    } else {
      Navigator.of(context).pop();
      showAlertOptions(
        context,
        msg: "Ha ocurrido un error con el servicio. Intente mas tarde",
        title: "Importante"
      );
    }
    //notifyListeners();
  }

  bool loginButtonDisabled(){
    if(documentRegex.hasMatch(documentController.value.text) && passwordRegex.hasMatch(documentController.value.text)){
      return false;
    }
    return true;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    documentController.dispose();
    passwordController.dispose();
    log("[LoginController] disposed");
  }
}

final loginController = ChangeNotifierProvider.autoDispose((_) => LoginController());