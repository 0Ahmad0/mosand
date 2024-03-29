import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:mosand/controller/provider/chat_provider.dart';
import 'package:mosand/controller/utils/firebase.dart';
import 'package:mosand/model/models.dart';
import 'package:mosand/model/utils/consts_manager.dart';
import 'package:mosand/view/all_lawyers/all_lawyers_view.dart';
import 'package:mosand/view/manager/widgets/button_app.dart';
import 'package:mosand/view/resourse/color_manager.dart';
import 'package:mosand/view/resourse/assets_manager.dart';
import 'package:provider/provider.dart';
import '../../controller/home_controller.dart';
import '../../controller/provider/profile_provider.dart';
import '../../model/utils/const.dart';
import '/view/manager/widgets/textformfiled_app.dart';
import '/view/resourse/style_manager.dart';
import '/view/select_specialty_lawyer/select_specialty_lawyer_view.dart';
import 'package:sizer/sizer.dart';

import '/translations/locale_keys.g.dart';
import '/view/resourse/values_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';


class HomeView extends StatefulWidget {
   HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late HomeController homeController;

  @override
  Widget build(BuildContext context) {
    homeController=HomeController(context: context);
    homeController.dateOController.dateOProvider.dateO=DateO.init();
    return StatefulBuilder(builder: (_, setStateL) {
      return ListView(
        padding: const EdgeInsets.all(AppPadding.p12),
        children: [
          Text(tr(LocaleKeys.welcome),style: getBoldStyle(
              color: Theme.of(context).textTheme.labelMedium!.color,
              fontSize: 24.sp
          ),),
          Text(tr(LocaleKeys.welcome_back)),
          Divider(
            thickness: 2,

          ),
          Text(tr(LocaleKeys.telephone_consultation),style: getBoldStyle(
              color: Theme.of(context).textTheme.labelMedium!.color,
              fontSize: 24.sp
          ),),
          Text(tr(LocaleKeys.telephone_consultation_steps)),
          const SizedBox(height: AppSize.s10,),
          Text(tr(LocaleKeys.specialty_lawyer),style: getBoldStyle(
              color: Theme.of(context).textTheme.labelMedium!.color,
              fontSize: 24.sp
          ),),
          Text(tr(LocaleKeys.select_specialty_lawyer)),
          const SizedBox(height: AppSize.s10,),
          TextFiledApp(
            controller: homeController.specialtyLawyerController,
            readOnly: true,
            onTap: (){
              Get.to(()=>SelectSpecialtyLawyerView())!.then((value) {
                homeController.specialtyLawyerController.text=value;
              });
            },
            iconData: FontAwesomeIcons.blackTie,
            hintText: tr(LocaleKeys.specialty_lawyer),
          ),
          const SizedBox(height: AppSize.s10,),
          Text(tr(LocaleKeys.subject_consultation),style: getBoldStyle(
              color: Theme.of(context).textTheme.labelMedium!.color,
              fontSize: 24.sp
          ),),
          Text(tr(LocaleKeys.select_subject_consultation)),
          const SizedBox(height: AppSize.s10,),
          TextFiledApp(
            controller: homeController.subjectConsultationController,
            iconData: Icons.subject,
            hintText: tr(LocaleKeys.subject_consultation),
          ),
          const SizedBox(height: AppSize.s10,),
          Text(tr(LocaleKeys.lawyer),style: getBoldStyle(
              color: Theme.of(context).textTheme.labelMedium!.color,
              fontSize: 24.sp
          ),),
          Text(tr(LocaleKeys.select_lawyer)),
          const SizedBox(height: AppSize.s10,),
          TextFiledApp(
            controller: homeController.idLawyerController,
            readOnly: true,
            onTap: (){
              Get.to(()=>AllLawyersView())!.then((value) async {
                if(value!=null){
                  homeController.lawyer=value;
                  homeController.idLawyerController.text=homeController.lawyer.name;
                  // var result =await ChatProvider().createChat(context,listIdUser:['mxa8VkmODNYM0QgEUiSq',homeController.lawyer.id]);
                  // print(result);
                  setStateL((){});
                }


              });
            },
            iconData: FontAwesomeIcons.user,
            hintText: tr(LocaleKeys.lawyer),
          ),
          const SizedBox(height: AppSize.s10,),
          if(homeController.idLawyerController.text!="")
            FutureBuilder<QuerySnapshot>(
              //prints the messages to the screen0
                future: homeController.fetchDateLawyerByIdLawyer(
                    idLawyer: homeController.lawyer.id),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return
                      Const.SHOWLOADINGINDECATOR();
                  }
                  {
                    if (snapshot.hasError) {
                      return const Text('Error');
                    } else if (snapshot.hasData) {
                      Const.SHOWLOADINGINDECATOR();
                      if (snapshot.data!.docs!.length > 0) {
                        homeController.dateLawyer=DateLawyer.fromJson(snapshot.data!.docs![0]);
                      }
                      return secondPhase(context);
                    } else {
                      return const Text('Empty data');
                    }
                  }

                }),


        ],
      );
    });
  }

  secondPhase(BuildContext context){
    return
      (!homeController.checkDateDayLawyer(homeController.dateLawyer))?
      SvgPicture.asset(AssetsManager.noDatesFoundIMG,width: 30.w,height: 30.w,)
          :
      StatefulBuilder(builder: (_, setStateD)
    =>
      ListBody(
          children: [
            Text(tr(LocaleKeys.telephone_consultation_schedule),
              style: getBoldStyle(
                  color: Theme
                      .of(context)
                      .textTheme
                      .labelMedium!
                      .color,
                  fontSize: 24.sp
              ),),
            Text(tr(LocaleKeys.please_choose_time_lawyer_to_contact_you)),
            const SizedBox(height: AppSize.s10,),
            DatePicker(
              DateTime.now(),
              width: 20.w,
              height: 15.h,
              initialSelectedDate: homeController.selectDateController,
              selectionColor: Theme
                  .of(context)
                  .primaryColor,
              locale: context.locale.toString(),
              onDateChange: (date) {
                homeController.selectDateController=date;
                setStateD((){});
               // print(date);
              },
            ),
            const SizedBox(height: AppSize.s10,),

            FutureBuilder<QuerySnapshot>(
              //prints the messages to the screen0
                future: homeController.fetchDate0ByIdLawyer(
                    idLawyer: homeController.lawyer.id),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return
                      (homeController.mapTimeDayLawyer.containsKey(homeController.selectDateController))?
                      buildDateLawyer(context):
                      Const.SHOWLOADINGINDECATOR();
                  }

                    if (snapshot.hasError) {
                      return const Text('Error');
                    } else if (snapshot.hasData) {
                      Const.SHOWLOADINGINDECATOR();
                     if (snapshot.data!.docs.length > 0) {
                       homeController.dateOController.dateOProvider.dateOs=DateOs.fromJson(snapshot.data!.docs);
                       //print(homeController.dateOController.dateOProvider.dateOs.toJson());
                     }
                        homeController.processTimeDay(dateTime: homeController.selectDateController);
                       // print(homeController.mapTimeDayLawyer);
                      //}
                      return buildDateLawyer(context);

                      /// }));
                  }
                  else {
                    return Text('State: ${snapshot.connectionState}');
                  }
                }),

          ])
    );
  }

   buildDateLawyer(BuildContext context){
    return
      (homeController.mapTimeDayLawyer[homeController.selectDateController]['am'].length+homeController.mapTimeDayLawyer[homeController.selectDateController]['pm'].length<=0)?
      SvgPicture.asset(AssetsManager.noTimeFoundIMG,width: 30.w,height: 30.w,):
      StatefulBuilder(builder: (_, setStateT) =>
      ListBody(
      children: [
        if(homeController.mapTimeDayLawyer[homeController.selectDateController]['am'].length>0)
          Text(tr(LocaleKeys.morning),style: getBoldStyle(
              color: Theme.of(context).textTheme.labelMedium!.color,
              fontSize: 24.sp
          ),),
        if(homeController.mapTimeDayLawyer[homeController.selectDateController]['am'].length>0)
          Wrap(
            alignment: WrapAlignment.center,
            children: [
              for(int i =0 ; i < homeController.mapTimeDayLawyer[homeController.selectDateController]['am'].length;i++)
                Container(
                margin: const EdgeInsets.symmetric(horizontal: AppMargin.m4),
                  child: InkWell(
                    onTap: (){
                      homeController.selectTimeDayController=homeController.mapTimeDayLawyer[homeController.selectDateController]['am'][i];
                      print('${homeController.selectTimeDayController}');
                      setStateT((){});},
                    child: Chip(
                      side: BorderSide(
                        color:                    (homeController.selectTimeDayController==homeController.mapTimeDayLawyer[homeController.selectDateController]['am'][i])
                            ? ColorManager.primaryColor
                            :Colors.transparent
                      ),
                      label: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('${homeController.mapTimeDayLawyer[homeController.selectDateController]['am'][i].format(context)}'),
                          const SizedBox(width: 5,),
                          Icon(Icons.access_time_filled_sharp
                          )
                        ],
                      ),

                    ),
                  ),
                )
            ],
          ),
        if(homeController.mapTimeDayLawyer[homeController.selectDateController]['pm'].length>0)
          Text(tr(LocaleKeys.evening),style: getBoldStyle(
              color: Theme.of(context).textTheme.labelMedium!.color,
              fontSize: 24.sp
          ),),
        if(homeController.mapTimeDayLawyer[homeController.selectDateController]['pm'].length>0)
          Wrap(
            alignment: WrapAlignment.center,
            children: [
              for(int i =0 ; i < homeController.mapTimeDayLawyer[homeController.selectDateController]['pm'].length;i++)
                Container(
                ///TODO add border
                  ///with cond : (homeController.selectTimeDayController==homeController.mapTimeDayLawyer[homeController.selectDateController]['am'][i])
                  margin: const EdgeInsets.symmetric(horizontal: AppMargin.m4),
                  child: InkWell(
                    onTap: (){
                      homeController.selectTimeDayController=homeController.mapTimeDayLawyer[homeController.selectDateController]['pm'][i];
                      print('${homeController.selectTimeDayController}');
                      setStateT((){});},
                    child: Chip(
                      side: BorderSide(
                          color:                    (homeController.selectTimeDayController==homeController.mapTimeDayLawyer[homeController.selectDateController]['pm'][i])
                              ? ColorManager.primaryColor
                              :Colors.transparent
                      ),
                      label: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('${homeController.mapTimeDayLawyer[homeController.selectDateController]['pm'][i].format(context)}'),
                          const SizedBox(width: 5,),
                          Icon(Icons.access_time_filled_sharp)
                        ],
                      ),

                    ),
                  ),
                )
            ],
          ),
        const SizedBox(height: AppSize.s10,),
        ButtonApp(text: tr(LocaleKeys.next), onPressed: () async {
        var result= await  homeController.addDateO(context);
         if(result['status'])
          setState(() {

          });
        })
      ],
      ));
   }
}