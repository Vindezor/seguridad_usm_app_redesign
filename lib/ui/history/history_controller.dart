import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:test_design/global/global_dialog.dart';
import 'package:test_design/global/global_loading.dart';
import 'package:test_design/models/travel_model.dart';
import 'package:test_design/models/travels_model.dart';
import 'package:test_design/services/travel_service.dart';
import 'package:test_design/ui/admin_map/travel_info/travel_info.dart';

class HistoryController extends ChangeNotifier{
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  final TravelService travelService = TravelService(Dio());
  List<Travel>? travels;

  HistoryController();

  history(context) async {
    final idTypeUser = int.parse((await storage.read(key: 'id_type_user'))!);
    globalLoading(context);
    TravelsModel? response;
    if(idTypeUser == 1){
      response = await travelService.historyUser();
    } else if (idTypeUser == 2){
      response = await travelService.historyDriver();
    } else {
      response = await travelService.historyAdmin();
    }
    if(response != null){
      if(response.status == "SUCCESS"){
        travels = response.data;
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

  showInfo(context, travel){
    // Travel infoTravel = travel;
    // log("${infoTravel.startTime}");
    // infoTravel.startTime = infoTravel.startTime.toLocal();
    //  log("${infoTravel.startTime}");
    // if(infoTravel.endTime != null){
    //   infoTravel.endTime = infoTravel.endTime!.toLocal();
    // }
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (_)  {
      return TravelInfo(selectedTravel: travel,);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    log("[HistoryController] disposed");
  }
}

final historyController = ChangeNotifierProvider.autoDispose((_) => HistoryController());