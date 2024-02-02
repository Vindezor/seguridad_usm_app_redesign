import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:test_design/global/global_dialog.dart';
import 'package:test_design/global/global_loading.dart';
import 'package:test_design/models/update_user_model.dart';
import 'package:test_design/services/user_service.dart';

class CompleteProfileController extends ChangeNotifier{
  
  CompleteProfileController(){
    log("[CompleteProfileController] init");
    passwordFocusNode.addListener(() {
      passwordTouched = true;
      notifyListeners();
    });
    confirmPasswordFocusNode.addListener(() {
      confirmPasswordTouched = true;
      notifyListeners();
    });
    emergencyEmailFocusNode.addListener(() {
      emergencyEmailTouched = true;
      notifyListeners();
    });
    phoneFocusNode.addListener(() {
      phoneTouched = true;
      notifyListeners();
    });
    emergencyPhoneFocusNode.addListener(() {
      emergencyPhoneTouched = true;
      notifyListeners();
    });
  }

  final UserService userService = UserService(Dio());

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController emergencyEmailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emergencyPhoneController = TextEditingController();

  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode confirmPasswordFocusNode = FocusNode();
  final FocusNode emergencyEmailFocusNode = FocusNode();
  final FocusNode phoneFocusNode = FocusNode();
  final FocusNode emergencyPhoneFocusNode = FocusNode();

  final passwordRegex = RegExp(r'^[A-Za-z\d.,_\-@*#$]{8,15}$');
  final phoneRegex = RegExp(r'^\d{11}$');
  final emailRegex = RegExp(r'''(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])''');

  String passwordTooltip = "La contraseña debe tener entre 8 y 15 caracteres y puede incluir letras mayúsculas, minúsculas, números y los siguientes caracteres especiales: . , _ - @ * # \$";

  bool passwordTouched = false;
  bool confirmPasswordTouched = false;
  bool emergencyEmailTouched = false;
  bool phoneTouched = false;
  bool emergencyPhoneTouched = false;

  final storage = const FlutterSecureStorage();
  bool hidePassword = true;
  bool hideConfirmPassword = true;

  onPressHidePassword(){
    hidePassword = !hidePassword;
    notifyListeners();
  }
  
  onPressHideConfirmPassword(){
    hideConfirmPassword = !hideConfirmPassword;
    notifyListeners();
  }

  nextButtonDisabled(){
    if(passwordRegex.hasMatch(passwordController.value.text) && passwordRegex.hasMatch(confirmPasswordController.value.text) && passwordController.value.text == confirmPasswordController.value.text){
      return false;
    }
    return true;
  }

  saveButtonDisabled(){
    if(phoneRegex.hasMatch(phoneController.value.text) && phoneRegex.hasMatch(emergencyPhoneController.value.text) && emailRegex.hasMatch(emergencyEmailController.value.text)){
      return false;
    }
    return true;
  }

  changedInput(){
    notifyListeners();
  }

  passwordIsBad(){
    if(passwordRegex.hasMatch(passwordController.value.text)){
      return false;
    }
    return true;
  }

  confirmPasswordIsBad(){
    if(passwordController.value.text == confirmPasswordController.value.text){
      return false;
    }
    return true;
  }

  emergencyEmailIsBad(){
    if(emailRegex.hasMatch(emergencyEmailController.value.text)){
      return false;
    }
    return true;
  }

  phoneIsBad(){
    if(phoneRegex.hasMatch(phoneController.value.text)){
      return false;
    }
    return true;
  }

  emergencyPhoneIsBad(){
    if(phoneRegex.hasMatch(emergencyPhoneController.value.text)){
      return false;
    }
    return true;
  }

  nextPage(context) async {
    final idTypeUser = await storage.read(key: 'id_type_user');
    if(["2", "3"].contains(idTypeUser)){
      save(context);
    } else {
      Navigator.of(context).pushNamed("/complete_profile_two");
    }
  }

  save(context) async {
    final idUser = await storage.read(key: 'id_user');
    final idTypeUser = await storage.read(key: 'id_type_user');
    globalLoading(context);
    final UpdateUserModel? response = await userService.updateUser(
      id_user: int.parse(idUser!),
      emergency_email: ["2", "3"].contains(idTypeUser) ? null : emergencyEmailController.value.text,
      emergency_phone: ["2", "3"].contains(idTypeUser) ? null : emergencyPhoneController.value.text,
      phone: ["2", "3"].contains(idTypeUser) ? null : phoneController.value.text,
      password: passwordController.value.text,
    );
    if(response != null){
      if(response.status == "SUCCESS"){
        Navigator.of(context).pop();
        showAlertOptions(
          context,
          justified: true,
          msg: "¡Perfil completado con éxito! Bienvenido/a al sistema. Ahora puedes disfrutar de todas las funciones. ¡Gracias por unirte!",
          title: "¡Enhorabuena!",
          closeOnPressed: () async {
            await storage.write(key: "id_user", value: response.data!.id.toString());
            await storage.write(key: "document", value: response.data!.document);
            await storage.write(key: "email", value: response.data!.email);
            await storage.write(key: "expiration_date", value: response.data!.expirationDate.toString());
            await storage.write(key: "university_code", value: response.data!.universityCode);
            await storage.write(key: "full_name", value: response.data!.fullName);
            await storage.write(key: "emergency_email", value: response.data!.emergencyEmail);
            await storage.write(key: "emergency_phone", value: response.data!.emergencyPhone);
            await storage.write(key: "creation_date", value: response.data!.creationDate.toString());
            await storage.write(key: "is_active", value: response.data!.isActive.toString());
            await storage.write(key: "phone", value: response.data!.phone);
            await storage.write(key: "type_user", value: response.data!.typeUser.typeUser);
            Navigator.of(context).pop();
            Navigator.of(context).pop();
            Navigator.of(context).pushReplacementNamed('/home');
            if(["1", "2"].contains(idTypeUser)) Navigator.of(context).pushNamed('/guide');
          }
        );
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
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    emergencyEmailController.dispose();
    phoneController.dispose();
    emergencyPhoneController.dispose();
    log("[CompleteProfileController] disposed");
  }
}

final completeProfileController = ChangeNotifierProvider.autoDispose((_) => CompleteProfileController());