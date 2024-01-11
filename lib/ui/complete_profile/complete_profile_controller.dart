import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CompleteProfileController extends ChangeNotifier{
  
  CompleteProfileController(){
    log("[CompleteProfileController] init");
  }

  //int value;
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

  save(context){
    Navigator.of(context).pushNamed("/home");
    log("save");
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