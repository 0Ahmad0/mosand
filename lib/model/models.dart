import 'package:flutter/cupertino.dart';
class Meal{
  String name;
  String price;
  List<String> ingredients;

  Meal({required this.name,required this.price,required this.ingredients});
}
class LawyerSchedule{
  TextEditingController? fromController;
  TextEditingController? toController;
  String? formHour;
  String? toHour;
  LawyerSchedule({this.formHour, this.toHour,this.fromController,this.toController});

}
/*
flutter pub run easy_localization:generate -S "assets/translations/" -O "lib/translations"
flutter pub run easy_localization:generate -S "assets/translations/" -O "lib/translations" -o "locale_keys.g.dart" -f keys
flutter build apk --split-per-abi
temp@gmail.com   123456
 */
