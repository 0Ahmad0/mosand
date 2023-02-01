import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mosand/controller/provider/auth_provider.dart';
import 'package:mosand/controller/provider/internship_provider.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart';
import '../model/models.dart';
import '../model/utils/const.dart';
import '../view/home/home_view.dart';
import '../view/navbar/navbar.dart';

class InternshipController{
  late InternshipProvider internshipProvider;
  var context;
  InternshipController({required this.context}){
    internshipProvider= Provider.of<InternshipProvider>(context);
  }
  addInternship(context,{ required Internship internship}) async {
    Const.LOADIG(context);
    var result= await internshipProvider.addInternship(context,internship: internship);
    Get.back();
    if(result['status'])
    Get.off(NavbarView());
  }
  deleteInternship(context,{ required Internship internship}) async {
    Const.LOADIG(context);
    await internshipProvider.deleteInternship(context,internship: internship);
    Get.back();
  }
}