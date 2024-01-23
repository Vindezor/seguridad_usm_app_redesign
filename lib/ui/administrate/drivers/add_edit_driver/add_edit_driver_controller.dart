import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_design/global/global_dialog.dart';
import 'package:test_design/global/global_loading.dart';
import 'package:test_design/models/login_model.dart';
import 'package:test_design/models/user_model.dart';
import 'package:test_design/services/user_service.dart';

class AddEditDriverController extends ChangeNotifier{

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController documentController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final UserService driverService = UserService(Dio());

  bool checked = false;
  bool editing = false;

  User? driver;

  AddEditDriverController();

  check(args){
    if(args != null){
      driver = User.fromJson(args["driver"]);
      fullNameController.text = driver!.fullName!;
      documentController.text = driver!.document!;
      phoneController.text = driver!.phone!;
      emailController.text = driver!.email!;
      editing = true;
    }
    checked = true;
    notifyListeners();
  }

  changeName(){
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
    return true;
  }

  save(context) async {
    globalLoading(context);
    UserModel? response;
    if(editing) {
      response = await driverService.updateDriver(
        id: driver!.id,
        fullName: fullNameController.value.text,
        document: documentController.value.text,
        phone: phoneController.value.text,
        email: emailController.value.text,
        password: passwordController.value.text,
      );
    } else {
      response = await driverService.createDriver(
        fullName: fullNameController.value.text,
        document: documentController.value.text,
        phone: phoneController.value.text,
        email: emailController.value.text,
        password: passwordController.value.text,
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
    passwordController.dispose();
    confirmPasswordController.dispose();
    log("[AddEditDriverController] disposed");
  }
}

final addEditDriverController = ChangeNotifierProvider.autoDispose((_) => AddEditDriverController());