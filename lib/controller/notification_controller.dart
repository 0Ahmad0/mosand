import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mosand/controller/date_controller.dart';
import 'package:mosand/controller/provider/auth_provider.dart';
import 'package:mosand/controller/provider/date_provider.dart';
import 'package:mosand/controller/provider/internship_provider.dart';
import 'package:mosand/controller/provider/profile_provider.dart';
import 'package:mosand/controller/utils/firebase.dart';
import 'package:mosand/model/utils/consts_manager.dart';
import 'package:mosand/translations/locale_keys.g.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart';
import '../model/models.dart';
import '../model/utils/const.dart';
import '../view/home/home_view.dart';
import '../view/navbar/navbar.dart';

class NotificationController{
  late DateOController dateOController;
  List<Map<String,dynamic>> listNotification=[];
  var context;
  NotificationController({required this.context}){
    dateOController= DateOController(context: context);
  }

  processNotification(BuildContext context,List<DateO> listDateOs){
    ProfileProvider profileProvider= Provider.of<ProfileProvider>(context);;
    dateOController.processDateOs(listDateOs);
    listNotification.clear();
    if(profileProvider.user.typeUser.contains(AppConstants.collectionLawyer))
      processNotificationLawyer(context);
    else if(profileProvider.user.typeUser.contains(AppConstants.collectionUser))
      processNotificationUser(context);
  }
  processNotificationLawyer(BuildContext context){
    listNotification.clear();
    for(DateO dateO in dateOController.listDateProgress){
      if(!dateO.notificationLawyer){
        listNotification.add({
          'message':'${tr(LocaleKeys.new_date_added)}',
          'dateO':dateO
        });
      }
      for(DateO dateO in dateOController.listDateUpcoming){
        if(!dateO.notificationLawyer){
          listNotification.add({
            'message':'${tr(LocaleKeys.you_have_appointment_today)}',
            'dateO':dateO
          });
        }
    }
    }
  }
  processNotificationUser(BuildContext context){
    listNotification.clear();
      for(DateO dateO in dateOController.listDateUpcoming){
        if(!dateO.notificationUser){
          listNotification.add({
            'message':'${tr(LocaleKeys.you_have_appointment_today)}',
            'dateO':dateO
          });
        }
      }
    }
  deleteNotification(BuildContext context,DateO dateO) async {
    ProfileProvider profileProvider= Provider.of<ProfileProvider>(context,listen: false);
    if(profileProvider.user.typeUser.contains(AppConstants.collectionLawyer))
      dateO.notificationLawyer=true;
    else if(profileProvider.user.typeUser.contains(AppConstants.collectionUser))
      dateO.notificationUser=true;
    await dateOController.dateOProvider.updateDateO(context, dateO: dateO);
  }
  }
