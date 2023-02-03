import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mosand/controller/date_lawyer_controller.dart';
import 'package:mosand/controller/provider/date_lawyer_provider.dart';
import 'package:mosand/model/models.dart';
import 'package:mosand/model/utils/consts_manager.dart';
import 'package:mosand/translations/locale_keys.g.dart';
import 'package:mosand/view/manager/widgets/ShadowContainer.dart';
import 'package:mosand/view/resourse/style_manager.dart';
import 'package:mosand/view/resourse/values_manager.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../controller/provider/profile_provider.dart';
import '../../../model/utils/const.dart';
import '../../resourse/const_manager.dart';

class AddDateView extends StatefulWidget {
  @override
  State<AddDateView> createState() => _AddDateViewState();
}

class _AddDateViewState extends State<AddDateView> {
  final _currentDate = DateTime(2023,1,29);
  late DateLawyerController dateLawyerController;
  bool checkUpdate=false;
  int _currentIndex = 0;
  Map<String, dynamic> textController = {
    "0": {
      "from": TextEditingController(),
      "to": TextEditingController(),
    },
    "1": {
      "from": TextEditingController(),
      "to": TextEditingController(),
    },
    "2": {
      "from": TextEditingController(),
      "to": TextEditingController(),
    },
    "3": {
      "from": TextEditingController(),
      "to": TextEditingController(),
    },
    "4": {
      "from": TextEditingController(),
      "to": TextEditingController(),
    },
    "5": {
      "from": TextEditingController(),
      "to": TextEditingController(),
    },
    "6": {
      "from": TextEditingController(),
      "to": TextEditingController(),
    },
  };
var setStateO;
  late ProfileProvider profileProvider;
  var getDateLawyer;
  @override
  void initState() {
    profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    getDateLawyerFun();
    super.initState();
  }

  getDateLawyerFun() async {
    getDateLawyer = FirebaseFirestore.instance
        .collection(AppConstants.collectionDateLawyer)
    .where('idLawyer',isEqualTo: profileProvider.user.id)
        .snapshots();

    return getDateLawyer;
  }
  @override
  Widget build(BuildContext context) {
    dateLawyerController=DateLawyerController(context: context);
    final _dayFormatter = DateFormat('EEEE', context.locale.toString());

    final datesWeekDay = <String>[];
    final datesHour = <LawyerSchedule>[];

    for (int i = 0; i < 7; i++) {
      final date = _currentDate.add(Duration(days: i));
      datesWeekDay.add(_dayFormatter.format(date).toLocale().toString());
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(tr(LocaleKeys.add_date)),
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppPadding.p12),
        child:StreamBuilder<QuerySnapshot>(
          //prints the messages to the screen0
            stream: getDateLawyer,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return
                  Const.SHOWLOADINGINDECATOR();

              }
              else if (snapshot.connectionState ==
                  ConnectionState.active) {
                if (snapshot.hasError) {
                  return const Text('Error');
                } else if (snapshot.hasData) {
                  Const.SHOWLOADINGINDECATOR();
                  if(snapshot.data!.docs!.length>0){
                    dateLawyerController.dateLawyerProvider.dateLawyer=DateLawyer.fromJson(snapshot.data?.docs[0]);
                    dateLawyerController.dateLawyerProvider.dateLawyer.id=snapshot.data!.docs[0]!.id;
                    for (int i = 0; i < 7; i++) {
                      if(dateLawyerController.dateLawyerProvider.dateLawyer.dateDays[i.toString()].to!=null){

                        textController[i.toString()]['from'].text=dateLawyerController.dateLawyerProvider.dateLawyer.dateDays[i.toString()].from.format(context);
                        textController[i.toString()]['to'].text=dateLawyerController.dateLawyerProvider.dateLawyer.dateDays[i.toString()].to.format(context);

                      }
                    }
                  }else{
                    dateLawyerController.dateLawyerProvider.dateLawyer.dateDays.clear();
                  }

                  return buildDateWeek(datesWeekDay);
                  /// }));
                } else {
                  return const Text('Empty data');
                }
              }
              else {
                return Text('State: ${snapshot.connectionState}');
              }
            }),
      ),
      floatingActionButton:
      // ChangeNotifierProvider<DateLawyerProvider>.value(
      //     value: dateLawyerController.dateLawyerProvider,
      //     child: Consumer<DateLawyerProvider>(
      //         builder: (context, value, child) {
    StatefulBuilder(builder: (_, setState1) {
    setStateO=setState1;
                return (checkUpdate)?Container(
                  height: 15.w,
                  width: 15.w,
                  child: FittedBox(
                    child: FloatingActionButton(
                      child: Icon(Icons.update,size: 7.w,),
                      onPressed: () async {
                        var result=await dateLawyerController.addOrUpdateDateLawyer(context, dateLawyerController: textController);
                        if(result['status'])
                          {
                            checkUpdate=false;
                            setState1(() {

                            });
                          }
                      },

                    ),
                  ),
                )
                    :SizedBox();
                })
             // }))

    );
  }
  buildDateWeek(List datesWeekDay){
   return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (int i = 0; i < datesWeekDay.length; i++)
          // ChangeNotifierProvider<DateLawyerProvider>.value(
          //     value: dateLawyerController.dateLawyerProvider,
          //     child: Consumer<DateLawyerProvider>(
          //         builder: (context, value, child) {
          //           return
                      Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              margin:
                              const EdgeInsets.symmetric(vertical: AppMargin.m10),
                              decoration: BoxDecoration(
                                  color: ((textController[i.toString()]['from']
                                      .text
                                      .toString()
                                      .isEmpty) ||
                                      textController[i.toString()]['to']
                                          .text.toString().isEmpty)
                                      ? Theme.of(context).cardColor
                                      : Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(AppSize.s8)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    datesWeekDay[i],
                                    style: getRegularStyle(
                                        color: ((textController[i.toString()]['from']
                                            .text
                                            .toString()
                                            .isEmpty) ||
                                            textController[i.toString()]['to']
                                                .text.toString().isEmpty)
                                            ? Theme.of(context).primaryColor
                                            : Theme.of(context).cardColor,
                                        fontSize: 14.sp),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: AppSize.s4,
                          ),
                          Expanded(
                            flex: 4,
                            child: Row(
                              children: [
                                Expanded(
                                    child: Container(
                                      height: double.infinity,
                                      margin: const EdgeInsets.symmetric(
                                          vertical: AppMargin.m10),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: AppPadding.p12),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Theme
                                                .of(context)
                                                .primaryColor,
                                          ),
                                          borderRadius:
                                          BorderRadius.circular(AppSize.s8)),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceBetween,
                                        children: [
                                          Expanded(child: TextField(
                                            controller: textController[i
                                                .toString()]['from'],
                                            readOnly: true,
                                            decoration: InputDecoration(
                                              hintText: tr(LocaleKeys.from),
                                              border: InputBorder.none,
                                              enabledBorder: InputBorder.none,
                                              focusedBorder: InputBorder.none,

                                            ),
                                            onTap: () {
                                              TimeOfDay time=TimeOfDay.now();
                                              if(textController[i
                                                  .toString()]['from'].text!='')
                                                time=dateLawyerController.stringToTimeOfDay(textController[i
                                                    .toString()]['from'].text);
                                              Navigator.of(context).push(
                                                showPicker(
                                                  context: context,
                                                  value: time,
                                                  onChange: (timeChange) {
                                                    // if(( timeChange.periodOffset<dateLawyerController.stringToTimeOfDay(textController[i
                                                    //     .toString()]['to'].text).periodOffset)){
                                                    textController[i
                                                        .toString()]['from'].text =
                                                        timeChange.format(context);

                                                    if(textController[i
                                                        .toString()]['to'].text!='')
                                                      checkUpdate=true;
                                                    else
                                                      checkUpdate=false;
                                                    setStateO(() {});



                                                  },
                                                ),
                                              );
                                            },
                                          )),
                                          const SizedBox(width: AppSize.s4,),
                                          const VerticalDivider(),
                                          const SizedBox(width: AppSize.s4,),
                                          Expanded(child: TextField(
                                            controller: textController[i
                                                .toString()]['to'],
                                            readOnly: true,
                                            decoration: InputDecoration(
                                              hintText: tr(LocaleKeys.to),
                                              border: InputBorder.none,
                                              enabledBorder: InputBorder.none,
                                              focusedBorder: InputBorder.none,

                                            ),
                                            onTap: () {
                                              TimeOfDay time=TimeOfDay.now();
                                              if(textController[i
                                                  .toString()]['from'].text!='')
                                                time=dateLawyerController.stringToTimeOfDay(textController[i
                                                    .toString()]['from'].text);
                                              Navigator.of(context).push(
                                                showPicker(
                                                  context: context,
                                                  value: time,
                                                  onChange: (timeChange) {
                                                    // if( timeChange.periodOffset>dateLawyerController.stringToTimeOfDay(textController[i
                                                    //     .toString()]['from'].text).periodOffset)

                                                    textController[i.toString()]['to'].text =
                                                        timeChange.format(context);
                                                    if(textController[i
                                                        .toString()]['from'].text!='')
                                                      checkUpdate=true;
                                                    else
                                                      checkUpdate=false;
                                                    setStateO(() {});



                                                  },
                                                ),
                                              );
                                            },
                                          )),

                                        ],
                                      ),
                                    )),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                 // }))
      ],
    );
  }
}
