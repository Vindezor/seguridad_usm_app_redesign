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
    return true;
  }

  nextPage(){
    log("next");
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    log("[CompleteProfileController] disposed");
  }
}

final completeProfileController = ChangeNotifierProvider.autoDispose((_) => CompleteProfileController());