import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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
  final storage = const FlutterSecureStorage();
  bool hidePassword = true;

  onPressHide(){
    hidePassword = !hidePassword;
    notifyListeners();
  }

  void login(context) async {
    globalLoading(context);
    final LoginModel? response = await userService.login(document: documentController.value.text, password: passwordController.value.text);
    if(response != null){
      if(response.status == "SUCCESS"){
        if(response.data != null){
          storage.write(key: "token", value: response.data?.token);
          if(response.data!.user.isActive){
            await storage.write(key: "id_user", value: response.data?.user.id.toString());
            await storage.write(key: "document", value: response.data?.user.document);
            await storage.write(key: "email", value: response.data?.user.email);
            await storage.write(key: "expiration_date", value: response.data?.user.expirationDate.toString());
            await storage.write(key: "university_code", value: response.data?.user.universityCode);
            await storage.write(key: "full_name", value: response.data?.user.fullName);
            await storage.write(key: "emergency_email", value: response.data?.user.emergencyEmail);
            await storage.write(key: "emergency_phone", value: response.data?.user.emergencyPhone);
            await storage.write(key: "creation_date", value: response.data?.user.creationDate.toString());
            await storage.write(key: "is_active", value: response.data?.user.isActive.toString());
            await storage.write(key: "phone", value: response.data?.user.phone);
            await storage.write(key: "type_user", value: response.data?.user.typeUser.typeUser);
            Navigator.of(context).pop();
            Navigator.pushReplacementNamed(context, '/home');
          } else {
            await storage.write(key: "id_user", value: response.data?.user.id.toString());
            Navigator.of(context).pop();
            Navigator.pushReplacementNamed(context, '/complete_profile_one');
          }
        }
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
        Navigator.of(context).pop();
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
    if(documentRegex.hasMatch(documentController.value.text) && passwordRegex.hasMatch(passwordController.value.text)){
      return false;
    }
    return true;
  }

  changedInput(){
    notifyListeners();
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