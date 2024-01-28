import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_design/global/global_dialog.dart';
import 'package:test_design/global/global_loading.dart';
import 'package:test_design/models/login_model.dart';
import 'package:test_design/models/user_model.dart';
import 'package:test_design/services/user_service.dart';

class AddEditAdminController extends ChangeNotifier{

  final FocusNode fullNameFocusNode = FocusNode();
  final FocusNode documentFocusNode = FocusNode();
  final FocusNode phoneFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController documentController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  final fullNameRegex = RegExp(r'^[A-Za-zÁÉÍÓÚáéíóúüÜ]+(?:\s[A-Za-zÁÉÍÓÚáéíóúüÜ]+)+$');
  final documentRegex = RegExp(r'^\d{5,9}$');
  final phoneRegex = RegExp(r'^\d{11}$');
  final emailRegex = RegExp(r'''(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])''');
  
  // final TextEditingController passwordController = TextEditingController();
  // final TextEditingController confirmPasswordController = TextEditingController();
  final UserService adminService = UserService(Dio());

  bool checked = false;
  bool editing = false;

  User? admin;

  bool fullNameTouched = false;
  bool documentTouched = false;
  bool phoneTouched = false;
  bool emailTouched = false;

  AddEditAdminController(){
    fullNameFocusNode.addListener(() {
      fullNameTouched = true;
      notifyListeners();
    });
    documentFocusNode.addListener(() {
      documentTouched = true;
      notifyListeners();
    });
    phoneFocusNode.addListener(() {
      phoneTouched = true;
      notifyListeners();
    });
    emailFocusNode.addListener(() {
      emailTouched = true;
      notifyListeners();
    });
  }

  fullNameIsBad(){
    if(fullNameRegex.hasMatch(fullNameController.value.text)){
      return false;
    }
    return true;
  }

  documentIsBad(){
    if(documentRegex.hasMatch(documentController.value.text)){
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

  emailIsBad(){
    if(emailRegex.hasMatch(emailController.value.text)){
      return false;
    }
    return true;
  }


  check(args){
    if(args != null){
      admin = User.fromJson(args["admin"]);
      fullNameController.text = admin!.fullName!;
      documentController.text = admin!.document!;
      phoneController.text = admin!.phone!;
      emailController.text = admin!.email!;
      editing = true;
    }
    checked = true;
    notifyListeners();
  }

  changeInput(){
    notifyListeners();
  }

  // changeCoordinates(LatLng pos){
  //   coordinateController.text = '${pos.latitude},${pos.longitude}';
  //   notifyListeners();
  // }

  buttonDisabled(){
    // if(nameController.value.text != "" && coordinateController.value.text != ""){
    //   return false;
    // }
    return false;
  }

  save(context) async {
    globalLoading(context);
    UserModel? response;
    if(editing) {
      response = await adminService.updateAdmin(
        id: admin!.id,
        fullName: fullNameController.value.text,
        document: documentController.value.text,
        phone: phoneController.value.text,
        email: emailController.value.text,
        //password: passwordController.value.text,
      );
    } else {
      response = await adminService.createAdmin(
        fullName: fullNameController.value.text,
        document: documentController.value.text,
        phone: phoneController.value.text,
        email: emailController.value.text,
        //password: passwordController.value.text,
      );
    }
    if(response != null){
      if(response.status == "SUCCESS"){
        Navigator.of(context).pop();
        showAlertOptions(
          context,
          msg: response.msg,
          title: "¡Enhorabuena!",
          closeOnPressed: () {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          }
        );
      } else {
        Navigator.of(context).pop();
        showAlertOptions(
          context,
          msg: response.msg,
          title: "Importante",
        );
      }
    } else {
      Navigator.of(context).pop();
      showAlertOptions(
        context,
        msg: "Ha ocurrido un error con el servicio. Intente mas tarde",
        title: "Importante",
      );
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    fullNameController.dispose();
    documentController.dispose();
    phoneController.dispose();
    emailController.dispose();
    fullNameFocusNode.dispose();
    documentFocusNode.dispose();
    phoneFocusNode.dispose();
    emailFocusNode.dispose();
    // passwordController.dispose();
    // confirmPasswordController.dispose();
    log("[AddEditAdminController] disposed");
  }
}

final addEditAdminController = ChangeNotifierProvider.autoDispose((_) => AddEditAdminController());