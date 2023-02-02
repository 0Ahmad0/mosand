import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mosand/model/models.dart';

import '../../model/utils/const.dart';
import '../utils/firebase.dart';


class DateOProvider extends ChangeNotifier{

  DateO dateO= DateO(idUser: "", idLawyer: "", specialtyLawyer: "", subjectConsultation: "", dateTime: DateTime.now());
  DateOs dateOs=DateOs(listDateO: []);

  addDateO(context,{ required DateO dateO}) async {
    var result;
    result =await FirebaseFun.addDateO(dateO: dateO);
       Const.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()));
       return result;
  }
  updateDateO(context,{ required DateO dateO}) async {
    var result;
    result =await FirebaseFun.updateDateO(dateO: dateO);
    Const.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()));
    return result;
  }
  deleteDateO(context,{ required DateO dateO}) async {
    var result;
    result =await FirebaseFun.deleteDateO(dateO: dateO);

    Const.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()));
    return result;
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
  compareTimeDayByHM({required TimeOfDay timeOfDay1,required TimeOfDay timeOfDay2}){
    int calDate1=timeOfDay1.hour*60+timeOfDay1.minute;
    int calDate2=timeOfDay2.hour*60+timeOfDay2.minute;

    if(calDate1>calDate2)
      return 1;
    else if(calDate1<calDate2)
      return -1;
    else return 0;
  }

}