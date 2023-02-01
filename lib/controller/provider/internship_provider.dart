import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mosand/model/models.dart';

import '../../model/utils/const.dart';
import '../utils/firebase.dart';


class InternshipProvider extends ChangeNotifier{
  Internship internship= Internship(internshipOpportunity: '', idLawyer: '', price: '0');
  Internships internships=Internships(listInternship: []);

  addInternship(context,{ required Internship internship}) async {
    var result;
    result =await FirebaseFun.addInternship(internship: internship);
    //print(result);
       Const.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()));
       return result;
  }
  deleteInternship(context,{ required Internship internship}) async {
    var result;
    result =await FirebaseFun.deleteInternship(internship: internship);
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