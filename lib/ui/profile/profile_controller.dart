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

  //int value;
  final TextEditingController emergencyEmailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emergencyPhoneController = TextEditingController();

  final FocusNode emergencyEmailFocusNode = FocusNode();
  final FocusNode phoneFocusNode = FocusNode();
  final FocusNode emergencyPhoneFocusNode = FocusNode();

  final phoneRegex = RegExp(r'^\d{11}$');
  final emailRegex = RegExp(r'''(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])''');

  String? email;
  String? emergencyEmail;
  String? phone;
  String? emergencyPhone;
  String? document;
  String? universityCode;
  DateTime? expirationDate = DateTime(2024);
  String? fullName;
  bool ready = false;

  bool emergencyEmailTouched = false;
  bool phoneTouched = false;
  bool emergencyPhoneTouched = false;

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

  goToEditProfile(context){
    emergencyEmailController.text = emergencyEmail!;
    phoneController.text = phone!;
    emergencyPhoneController.text = emergencyPhone!;
    showModalBottomSheet(
      backgroundColor: Colors.white,
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
      final exp = await storage.read(key: 'expiration_date');
      expirationDate = exp != null ? DateTime.parse(exp).toLocal() : null;
      ready = true;
      if(context.mounted) Navigator.of(context).pop();
      notifyListeners();
    }
  }

  changeInput(){
    notifyListeners();
  }

  String? getExpirationDate(){
    if(expirationDate != null){
      return '${expirationDate!.day.toString()}/${expirationDate!.month.toString()}/${expirationDate!.year.toString()}';
    }
    return null;
  }

  bool saveButtonDisabled(){
    if(emailRegex.hasMatch(emergencyEmailController.value.text) && phoneRegex.hasMatch(phoneController.value.text) && phoneRegex.hasMatch(emergencyPhoneController.value.text)){
      return false;
    }
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