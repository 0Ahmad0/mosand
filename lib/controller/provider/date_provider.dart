import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
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

}