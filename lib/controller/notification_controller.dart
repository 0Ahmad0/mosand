import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
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
  }
  processNotificationLawyer(BuildContext context){
    listNotification.clear();
    for(DateO dateO in dateOController.listDateProgress){
      if(!dateO.notificationLawyer){
        listNotification.add({
          'message':'',
          'dateO':dateO
        });
      }
      for(DateO dateO in dateOController.listDateUpcoming){
        if(!dateO.notificationLawyer){
          listNotification.add({
            'message':'',
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
            'message':'',
            'dateO':dateO
          });
        }
      }
    }
  }
