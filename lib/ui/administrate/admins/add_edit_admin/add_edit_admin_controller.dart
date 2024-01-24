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

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController documentController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  // final TextEditingController passwordController = TextEditingController();
  // final TextEditingController confirmPasswordController = TextEditingController();
  final UserService adminService = UserService(Dio());

  bool checked = false;
  bool editing = false;

  User? admin;

  AddEditAdminController();

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
    // passwordController.dispose();
    // confirmPasswordController.dispose();
    log("[AddEditAdminController] disposed");
  }
}

final addEditAdminController = ChangeNotifierProvider.autoDispose((_) => AddEditAdminController());