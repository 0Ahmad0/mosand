import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mosand/controller/provider/auth_provider.dart';
import 'package:mosand/controller/provider/chat_provider.dart';
import 'package:mosand/controller/provider/date_provider.dart';
import 'package:mosand/controller/provider/internship_provider.dart';
import 'package:mosand/controller/provider/profile_provider.dart';
import 'package:mosand/controller/utils/firebase.dart';
import 'package:mosand/model/utils/consts_manager.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart';
import '../model/models.dart';
import '../model/utils/const.dart';
import '../view/home/home_view.dart';
import '../view/navbar/navbar.dart';

class DateOController{
  late DateOProvider dateOProvider;
  List<DateO> listDateProgress=[];
  List<DateO> listDateUpcoming=[];
  List<DateO> listDateComplete=[];
  var context;
  DateOController({required this.context}){
    dateOProvider= Provider.of<DateOProvider>(context);
  }
  addDateO(context,{ required DateO dateO}) async {
    Const.LOADIG(context);
    var result;
     result= await dateOProvider.addDateO(context,dateO: dateO);
    if(!result['status'])
      Const.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()));
    Get.back();
    return result;
    // if(result['status'])
    // Get.off(NavbarView());
  }
  deleteDateO(context,{ required DateO dateO}) async {
    Const.LOADIG(context);
    await dateOProvider.deleteDateO(context,dateO: dateO);
    Get.back();
  }
  updateDateO(context,{ required DateO dateO}) async {
    Const.LOADIG(context);
    await dateOProvider.updateDateO(context,dateO: dateO);
    Get.back();
  }
  fetchDateOsByUserOrLawyerStream(BuildContext context){
    final ProfileProvider profileProvider= Provider.of<ProfileProvider>(context,listen: false);

    if(profileProvider.user.typeUser.contains(AppConstants.collectionUser))
      return FirebaseFirestore.instance.collection(AppConstants.collectionDateO)
          .where('idUser',isEqualTo: profileProvider.user.id).snapshots();
    else if(profileProvider.user.typeUser.contains(AppConstants.collectionLawyer))
     return FirebaseFirestore.instance.collection(AppConstants.collectionDateO)
        .where('idLawyer',isEqualTo: profileProvider.user.id).snapshots();
    else
      return FirebaseFirestore.instance.collection(AppConstants.collectionDateO)
          .where('idUser',isEqualTo: profileProvider.user.id).snapshots();
  }
  fetchDateOsByUserOrLawyer(context) async {
    final ProfileProvider profileProvider= Provider.of<ProfileProvider>(context,listen: false);
    var result;
    if(profileProvider.user.typeUser.contains(AppConstants.collectionUser))
      result=await FirebaseFun.fetchDateOsByUser(idUser: profileProvider.user.id);
    else if(profileProvider.user.typeUser.contains(AppConstants.collectionLawyer))
      result=await FirebaseFun.fetchDateOsByLawyer(idLawyer: profileProvider.user.id);
    if(result['status']){
      dateOProvider.dateOs=DateOs.fromJson(result['body']);
      processDateOs(dateOProvider.dateOs.listDateO);
    }
    return result;
  }
  processDateOs(List<DateO> listDateOs){
    listDateComplete.clear();
    listDateProgress.clear();
    listDateUpcoming.clear();
    for(DateO dateO in listDateOs){
      if(dateOProvider.compareDateTimeByYMD(dateTime1: dateO.dateTime, dateTime2: DateTime.now())>0)
        listDateProgress.add(dateO);
      else if(dateOProvider.compareDateTimeByYMD(dateTime1: dateO.dateTime, dateTime2: DateTime.now())==0)
       {
         if(dateOProvider.compareTimeDayByHM(timeOfDay1: TimeOfDay(hour: dateO.dateTime.hour+1, minute: dateO.dateTime.minute), timeOfDay2: TimeOfDay.now())>0)
           listDateUpcoming.add(dateO);
         else
           listDateComplete.add(dateO);
       }
          else if(dateOProvider.compareDateTimeByYMD(dateTime1: dateO.dateTime, dateTime2: DateTime.now())<0)
        listDateComplete.add(dateO);
    }
  }
  getIdUserOrIdLawyer(BuildContext context,DateO dateO){
    ProfileProvider profileProvider= Provider.of<ProfileProvider>(context);
    if(!profileProvider.user.typeUser.contains(AppConstants.collectionUser))
      return dateO.idUser;
    else
      return dateO.idLawyer;
  }

}