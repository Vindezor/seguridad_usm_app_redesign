import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_design/global/global_dialog.dart';
import 'package:test_design/global/global_loading.dart';
import 'package:test_design/models/generic_model.dart';
import 'package:test_design/services/user_service.dart';

class RegisterController extends ChangeNotifier{
  
  RegisterController(){
    log("[RegisterController] init");
    codeFocusNode.addListener(() {
      codeTouched = true;
    });
  }

  bool codeTouched = false;
  //int value;
  final FocusNode codeFocusNode = FocusNode();

  final TextEditingController codeController = TextEditingController();
  final UserService userService = UserService(Dio());
  final regex = RegExp(r'^[a-zA-Z0-9]{7}$');

  void register(context) async {
    globalLoading(context);
    final GenericModel? response = await userService.register(university_code: codeController.value.text);
    if(response != null){
      Navigator.of(context).pop();
      if(response.status == "SUCCESS"){
        Navigator.pushReplacementNamed(context, '/register_successful');
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
  
  bool registerButtonDisabled(){
    if(regex.hasMatch(codeController.value.text)){
      return false;
    }
    return true;
  }

  void codeChanged(){
    notifyListeners();
  }

  void changeTextValue(String text){
    codeController.text = text;
    notifyListeners();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    codeController.dispose();
    log("[RegisterController] disposed");
  }
}

final registerController = ChangeNotifierProvider.autoDispose((_) => RegisterController());