import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_design/global/global_dialog.dart';
import 'package:test_design/global/global_loading.dart';
import 'package:test_design/models/update_user_model.dart';
import 'package:test_design/services/user_service.dart';

class CompleteProfileController extends ChangeNotifier{
  
  CompleteProfileController(){
    log("[CompleteProfileController] init");
  }

  final UserService userService = UserService(Dio());

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController emergencyEmailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emergencyPhoneController = TextEditingController();

  final passwordRegex = RegExp(r'^[A-Za-z\d.,_\-@*#$]{8,15}$');
  final phoneRegex = RegExp(r'^\d{11}$');
  final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+((com)|(es))$');

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

  nextPage(context){
    Navigator.of(context).pushNamed("/complete_profile_two");
    log("next");
  }

  save(context) async {
    globalLoading(context);
    final UpdateUserModel? response = await userService.updateUser(
      emergency_email: emergencyEmailController.value.text,
      emergency_phone: emergencyPhoneController.value.text,
      phone: phoneController.value.text,
      password: passwordController.value.text,
    );
    Navigator.of(context).pop();
    if(response != null){
      if(response.status == "SUCCESS"){
        Navigator.of(context).pop();
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        showAlertOptions(
          context,
          msg: response.msg,
          title: "Importante"
        );
      }
    } else {
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