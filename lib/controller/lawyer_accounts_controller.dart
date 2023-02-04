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
import 'package:mosand/view/navbar/navbar.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart';

import '../model/models.dart';
import '../model/utils/const.dart';


class LawyerAccountsController{

   Users lawyers=Users(users: []);
  fetchLawyers() async {
    lawyers.users.clear();
    final result=await FirebaseFun.fetchUsersByTypeUser(AppConstants.collectionLawyer);
    if(result['status']){
      lawyers=Users.fromJson(result['body']);
    }
    return result;
  }
  fetchLawyersStream()  {
    lawyers.users.clear();
    return FirebaseFirestore.instance.collection(AppConstants.collectionLawyer).snapshots();
  }
   changeStateUser(BuildContext context, {required User user})  async {
    user.active=!user.active;
   // Const.LOADIG(context);
     final result=await FirebaseFun.updateUser(user: user);
    //Get.back();
     if(!result['status'])
       Const.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()));

     return result;
   }

}