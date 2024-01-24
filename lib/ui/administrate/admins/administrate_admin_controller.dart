import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_design/global/global_dialog.dart';
import 'package:test_design/global/global_loading.dart';
import 'package:test_design/models/login_model.dart';
import 'package:test_design/services/user_service.dart';

class AdministrateAdminsController extends ChangeNotifier{

  final UserService adminService = UserService(Dio());
  List<User>? admins;

  AdministrateAdminsController();

  getAllAdmins(context) async {
    globalLoading(context);
    final response = await adminService.getAllAdmins();
    if(response != null){
      if(response.status == "SUCCESS"){
        admins = response.data;
        notifyListeners();
        Navigator.of(context).pop();
      } else {
        Navigator.of(context).pop();
        showAlertOptions(
          context,
          msg: response.msg!,
          title: "Importante",
          closeOnPressed: () {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          }
        );
      }
    } else {
      Navigator.of(context).pop();
      showAlertOptions(
        context,
        msg: "Ha ocurrido un error con el servicio. Intente mas tarde",
        title: "Importante",
        closeOnPressed: () {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        }
      );
    }
  }

  deleteAdmin(context, id){
    showAlertOptions(
      context,
      msg: "¿Seguro que desea eliminar este conductor?",
      title: "Importante",
      acceptOnPressed: () async {
        Navigator.of(context).pop();
        globalLoading(context);
        final response = await adminService.deleteAdmin(id);
        if(response != null){
          if(response.status == "SUCCESS"){
            Navigator.of(context).pop();
            showAlertOptions(
              context,
              msg: response.msg!,
              title: "¡Enhorabuena!",
              closeOnPressed: () {
                Navigator.of(context).pop();
                getAllAdmins(context);
              },
            );
          } else {
            Navigator.of(context).pop();
            showAlertOptions(
              context,
              msg: response.msg!,
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
      },
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    log("[AdministrateAdminsController] disposed");
  }
}

final administrateAdminsController = ChangeNotifierProvider.autoDispose((_) => AdministrateAdminsController());