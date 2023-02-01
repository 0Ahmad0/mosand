import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mosand/model/models.dart';

import '../../model/utils/const.dart';
import '../utils/firebase.dart';


class DateLawyerProvider extends ChangeNotifier{

  DateLawyer dateLawyer= DateLawyer(dateDays: {}, idLawyer: "");
  DateLawyers dateLawyers=DateLawyers(listDateLawyer: []);

  addDateLawyer(context,{ required DateLawyer dateLawyer}) async {
    var result;
    result =await FirebaseFun.addDateLawyer(dateLawyer: dateLawyer);
    //print(result);
       Const.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()));
       return result;
  }
  updateDateLawyer(context,{ required DateLawyer dateLawyer}) async {
    var result;
    result =await FirebaseFun.updateDateLawyer(dateLawyer: dateLawyer);
    //print(result);
    Const.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()));
    return result;
  }
  deleteDateLawyer(context,{ required DateLawyer dateLawyer}) async {
    var result;
    result =await FirebaseFun.deleteDateLawyer(dateLawyer: dateLawyer);
    //print(result);
    Const.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()));
    return result;
  }
  // fetchMeals () async {
  //   var result= await FirebaseFun.fetchMeals();
  //   if(result['status']){
  //     listMeals=Meals.fromJson(result['body']);
  //   }
  //   return result;
  // }


}