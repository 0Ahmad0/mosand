import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mosand/controller/provider/auth_provider.dart';
import 'package:mosand/controller/provider/date_provider.dart';
import 'package:mosand/controller/provider/internship_provider.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart';
import '../model/models.dart';
import '../model/utils/const.dart';
import '../view/home/home_view.dart';
import '../view/navbar/navbar.dart';

class DateOController{
  late DateOProvider dateOProvider;
  var context;
  DateOController({required this.context}){
    dateOProvider= Provider.of<DateOProvider>(context);
  }
  addDateO(context,{ required DateO dateO}) async {
    Const.LOADIG(context);
    var result= await dateOProvider.addDateO(context,dateO: dateO);
    Get.back();
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
}