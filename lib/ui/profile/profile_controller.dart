import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:test_design/global/global_dialog.dart';
import 'package:test_design/global/global_loading.dart';
import 'package:test_design/models/update_user_model.dart';
import 'package:test_design/services/user_service.dart';
import 'package:test_design/ui/profile/edit_profile.dart';

class ProfileController extends ChangeNotifier{
  
  ProfileController(){
    log("[ProfileController] init");
  }

  //int value;
  final TextEditingController emergencyEmailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emergencyPhoneController = TextEditingController();

  final FocusNode emergencyEmailFocusNode = FocusNode();
  final FocusNode phoneFocusNode = FocusNode();
  final FocusNode emergencyPhoneFocusNode = FocusNode();

  String? email = "";
  String? emergencyEmail = "";
  String? phone = "";
  String? emergencyPhone = "";
  String? document = "";
  String? universityCode = "";
  DateTime? expirationDate = DateTime(2024);
  String? fullName = "";
  bool ready = false;

  FlutterSecureStorage storage = const FlutterSecureStorage();

  final UserService userService = UserService(Dio());

  void save(context) async {
    final idUser = await storage.read(key: 'id_user');
    globalLoading(context);
    final UpdateUserModel? response = await userService.updateUser(
      emergency_email: emergencyEmailController.value.text,
      phone: phoneController.value.text,
      emergency_phone: emergencyPhoneController.value.text,
      id_user: int.parse(idUser!),
    );
    if(response != null){
      Navigator.of(context).pop();
      if(response.status == "SUCCESS"){
        showAlertOptions(
          context,
          msg: "Tu perfil ha sido actualizado exitosamente",
          title: "¡Enhorabuena!",
          closeOnPressed: () async {
            emergencyEmail = emergencyEmailController.value.text;
            phone = phoneController.value.text;
            emergencyPhone = emergencyPhoneController.value.text;
            await storage.write(key: 'emergency_email', value: emergencyEmail);
            await storage.write(key: 'phone', value: phone);
            await storage.write(key: 'emergency_phone', value: emergencyPhone);
            Navigator.of(context).pop();
            Navigator.of(context).pop();
            notifyListeners();
          },
          justified: false,
        );
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

  goToEditProfile(context){
    emergencyEmailController.text = emergencyEmail!;
    phoneController.text = phone!;
    emergencyPhoneController.text = emergencyPhone!;
    showModalBottomSheet(
      showDragHandle: true,
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return const EditProfile();
      }
    );
  }

  initProfile(context) async {
    if(!ready){
      log("initProfile");
      globalLoading(context);
      fullName = await storage.read(key: 'full_name');
      email = await storage.read(key: 'email');
      emergencyEmail = await storage.read(key: 'emergency_email');
      phone = await storage.read(key: 'phone');
      emergencyPhone = await storage.read(key: 'emergency_phone');
      document = await storage.read(key: 'document');
      universityCode = await storage.read(key: 'university_code');
      expirationDate = DateTime.parse((await storage.read(key: 'expiration_date'))!);
      ready = true;
      if(context.mounted) Navigator.of(context).pop();
      notifyListeners();
    }
  }

  String getExpirationDate(){
    return '${expirationDate!.day.toString()}/${expirationDate!.month.toString()}/${expirationDate!.year.toString()}';
  }

  bool saveButtonDisabled(){
    // if(regex.hasMatch(textEditingController.value.text)){
    //   return false;
    // }
    // return true;
    return true;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emergencyEmailController.dispose();
    phoneController.dispose();
    emergencyPhoneController.dispose();
    emergencyEmailFocusNode.dispose();
    phoneFocusNode.dispose();
    emergencyPhoneFocusNode.dispose();
    log("[ProfileController] disposed");
  }
}

final profileController = ChangeNotifierProvider.autoDispose<ProfileController>((_) => ProfileController());