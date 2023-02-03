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


class HomeController{
  late DateOController dateOController;
  final specialtyLawyerController =TextEditingController();
  final subjectConsultationController =TextEditingController();
  final idLawyerController =TextEditingController();
  DateTime selectDateController =DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day);
  TimeOfDay? selectTimeDayController;
  Map<DateTime,dynamic> mapTimeDayLawyer={};
  User lawyer =User.init();
  DateLawyer dateLawyer=DateLawyer(dateDays: {}, idLawyer: "");
  static Users lawyers=Users(users: []);
  var context;
  HomeController({required this.context}){
    dateOController= DateOController(context: context);
  }
  fetchLawyer() async {

    lawyers.users.clear();
    final result=await FirebaseFun.fetchUsersByTypeUser(AppConstants.collectionLawyer);
    if(result['status']){
      lawyers=Users.fromJson(result['body']);
    }
    return result;
  }
   fetchDateLawyerByIdLawyer({required String idLawyer})  {
    return  FirebaseFirestore.instance.
    collection(AppConstants.collectionDateLawyer)
        .where('idLawyer',isEqualTo: idLawyer)
        .get();
  }
  fetchDate0ByIdLawyer({required String idLawyer})  {
    return  FirebaseFirestore.instance.
    collection(AppConstants.collectionDateO)
        .where('idLawyer',isEqualTo: idLawyer)
        .get();
  }
  processTimeDay({required DateTime dateTime}){
    int weekday=dateTime.weekday;
    if(weekday>=7)
      weekday-=7;
    List<TimeOfDay> listHour=partDateDayToListHours(dateLawyer.dateDays[weekday.toString()]);

    List<TimeOfDay> listHoursUsers=findHoursUsersByDateDay(dateTime: dateTime, listHour: listHour, dateOs: dateOController.dateOProvider.dateOs);
    List<TimeOfDay> listHoursUsersAm=[];
    List<TimeOfDay> listHoursUsersPm=[];
    for(TimeOfDay timeOfDay in listHoursUsers){
      if(timeOfDay.hour>=12)
        listHoursUsersPm.add(timeOfDay);
      else
        listHoursUsersAm.add(timeOfDay);
    }
    Map mapTimeDay={};
    mapTimeDay['am']=listHoursUsersAm;
    mapTimeDay['pm']=listHoursUsersPm;
    mapTimeDayLawyer[dateTime]=mapTimeDay;
  }
  partDateDayToListHours(DateDay dateDay){
    List<TimeOfDay> listHour=[];
    if(dateDay.from==null)
      return listHour;
    for(TimeOfDay i=dateDay.from!;i.hour<dateDay.to!.hour;i=TimeOfDay(hour: i.hour+1, minute: i.minute)){
      listHour.add(i);

    }

    return listHour;
  }
  findHoursUsersByDateDay({required DateTime dateTime,required List<TimeOfDay> listHour,required DateOs dateOs}){
    List<TimeOfDay> listHoursUsers=[];
    listHoursUsers.addAll(listHour);
    for(DateO dateO in dateOs.listDateO){
      if(dateOController.dateOProvider.compareDateTimeByYMD(dateTime1: dateTime,dateTime2: dateO.dateTime)==0){
        TimeOfDay timeOfDate=TimeOfDay(hour: dateO.dateTime.hour, minute: dateO.dateTime.minute);
        for(TimeOfDay element in listHour){
          if(((timeOfDate.hour*60+timeOfDate.minute)-(element.hour*60+element.minute)).abs()<60)
            listHoursUsers.remove(element);
        }
      }
    }

   return listHoursUsers;
  }

  checkDateDayLawyer(DateLawyer dateLawyer){
    for(DateDay dateDay in dateLawyer.dateDays.values)
      if(dateDay.from!=null&&dateDay.to!=null) return true;
    return false;
  }
  addDateO(BuildContext context) async {
    final ProfileProvider profileProvider= Provider.of<ProfileProvider>(context,listen: false);
    var result;
    if(selectTimeDayController!=null
        &&subjectConsultationController.text!=''
        &&specialtyLawyerController.text!=''){
      DateO dateO=DateO(idUser: profileProvider.user.id,
          idLawyer: lawyer.id, specialtyLawyer: specialtyLawyerController.text,
          subjectConsultation: subjectConsultationController.text,
          dateTime:DateTime(selectDateController.year,selectDateController.month,selectDateController.day,selectTimeDayController!.hour,selectTimeDayController!.minute) );

     result =await dateOController.addDateO(context, dateO: dateO);

    }else{
      Const.TOAST(context,textToast: tr(LocaleKeys.please_fill_all_fields));
      result= FirebaseFun.errorUser(tr(LocaleKeys.please_fill_all_fields));
    }
    FocusManager.instance.primaryFocus!.unfocus();
    return result;
  }
}