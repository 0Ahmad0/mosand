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
import 'package:mosand/controller/utils/firebase.dart';
import 'package:mosand/model/utils/consts_manager.dart';
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
        .snapshots();
  }
  fetchDate0ByIdLawyer({required String idLawyer})  {
    return  FirebaseFirestore.instance.
    collection(AppConstants.collectionDateO)
        .where('idLawyer',isEqualTo: idLawyer)
        .snapshots();
  }
  processTimeDay({required DateTime dateTime}){
    int weekday=dateTime.weekday;
    if(weekday>=7)
      weekday-=7;
    List<TimeOfDay> listHour=partDateDayToListHours(dateLawyer.dateDays[weekday.toString()]);
    List<TimeOfDay> listHoursUsers=findHoursUsersByDateDay(dateTime: dateTime, listHoursUsers: listHour, dateOs: dateOController.dateOProvider.dateOs);
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
  findHoursUsersByDateDay({required DateTime dateTime,required List<TimeOfDay> listHoursUsers,required DateOs dateOs}){
    for(DateO dateO in dateOs.listDateO){
      if(compareDateTimeByYMD(dateTime1: dateTime,dateTime2: dateO.dateTime)==0){
        TimeOfDay timeOfDate=TimeOfDay(hour: dateO.dateTime.hour, minute: dateO.dateTime.minute);
        for(TimeOfDay element in listHoursUsers){
          if((timeOfDate.hour*60+timeOfDate.minute-60)<(element.hour*60+element.minute)
          ||(timeOfDate.hour*60+timeOfDate.minute+60)>(element.hour*60+element.minute))
            listHoursUsers.remove(element);
        }
      }
    }
   return listHoursUsers;
  }
  compareDateTimeByYMD({required DateTime dateTime1,required DateTime dateTime2}){
    int calDate1=dateTime1.year*365+dateTime1.month*12+dateTime1.day;
    int calDate2=dateTime1.year*365+dateTime2.month*12+dateTime2.day;
    if(calDate1>calDate2)
      return 1;
    else if(calDate1<calDate2)
        return -1;
    else return 0;
  }
}