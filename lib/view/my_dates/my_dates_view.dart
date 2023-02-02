import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mosand/controller/date_controller.dart';
import 'package:mosand/model/utils/consts_manager.dart';
import 'package:mosand/translations/locale_keys.g.dart';
import 'package:mosand/view/my_dates/widgets/build_item_dates.dart';
import 'package:mosand/view/resourse/color_manager.dart';
import 'package:mosand/view/resourse/const_manager.dart';
import 'package:mosand/view/resourse/style_manager.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../controller/provider/profile_provider.dart';
import '../../model/models.dart';
import '../../model/utils/const.dart';

class MyDatesView extends StatelessWidget {
  DateTime selectedDate = DateTime.now();
  late DateOController dateOController;
  @override
  Widget build(BuildContext context) {
    dateOController=DateOController(context: context);
    return DefaultTabController(
      length: ConstManager.tabBarLength,
      child: Scaffold(
        body: Column(
          children: [
            Container(
              color: Theme.of(context).primaryColor,
              child: TabBar(
                indicatorColor: Theme.of(context).cardColor,
                labelStyle: getRegularStyle(
                  color: Colors.white,
                  fontSize: 12.sp
                ),
                tabs: [
                  Tab(
                    text: tr(LocaleKeys.in_progress),
                  ),
                  Tab(
                    text: tr(LocaleKeys.upcoming),
                  ),
                  Tab(
                    text: tr(LocaleKeys.complete),
                  ),
                ],
              ),
            ),
            StreamBuilder<QuerySnapshot>(
              //prints the messages to the screen0
                stream: dateOController.fetchDateOsByUserOrLawyerStream(context),
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
                      if(snapshot.data!.docs.length>0){
                        dateOController.dateOProvider.dateOs=DateOs.fromJson(snapshot.data!.docs);
                        dateOController.processDateOs(dateOController.dateOProvider.dateOs.listDateO);
                      }
                      return buildDateViews(context);
                      /// }));
                    } else {
                      return const Text('Empty data');
                    }
                  }
                  else {
                    return Text('State: ${snapshot.connectionState}');
                  }
                }),
          ],
        ),
      ),
    );
  }
  buildDateViews(BuildContext context){
    ProfileProvider profileProvider= Provider.of<ProfileProvider>(context);
    return Expanded(
      child: TabBarView(
        children: [
          ListView.builder(
            itemCount: dateOController.listDateProgress.length,
            itemBuilder: (_,index)=>BuildItemDates(
                dateName: dateOController.listDateProgress[index].subjectConsultation,//"dateName",
                lawyerName: dateOController.getIdUserOrIdLawyer(context,dateOController.listDateProgress[index]),
                date: dateOController.listDateProgress[index].dateTime,
                onTap: (){},
                icon: Icons.delete_sweep,
                iconType: Icons.hourglass_top,
                onTapIcon: (){
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.error,
                    title: tr(LocaleKeys.this_item_will_be_deleted),
                    desc: tr(LocaleKeys.are_you_sure),
                    btnOkOnPress: () async {
                      await dateOController.deleteDateO(context, dateO: dateOController.listDateProgress[index]);
                    },
                    btnCancelOnPress: (){},
                    btnOkText: tr(LocaleKeys.ok),
                    btnCancelText: tr(LocaleKeys.cancel),
                  ).show();
                }
            ),
          ),
          ListView.builder(
            itemCount: dateOController.listDateUpcoming.length,
            itemBuilder: (_,index)=>BuildItemDates(
                dateName: dateOController.listDateUpcoming[index].subjectConsultation,
                lawyerName:  dateOController.getIdUserOrIdLawyer(context,dateOController.listDateUpcoming[index]),
                date: dateOController.listDateUpcoming[index].dateTime,
                onTap: (){

                },
                icon:(profileProvider.user.typeUser.contains(AppConstants.collectionUser))? Icons.edit_calendar:null,
                iconType: Icons.next_plan,
                colorIcon: ColorManager.primaryColor,
                onTapIcon: () async {
                  final t = await showDatePicker(
                    locale: context.locale,
                    context: context,
                    initialDate: selectedDate,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2050),
                  );
                  if(t !=null && t!=selectedDate){
                    print("====>${t}<====");
                    dateOController.listDateUpcoming[index].dateTime=DateTime(t.year,t.month,t.day,dateOController.listDateUpcoming[index].dateTime.hour,dateOController.listDateUpcoming[index].dateTime.minute);
                    dateOController.listDateUpcoming[index].notificationLawyer=false;
                    dateOController.listDateUpcoming[index].notificationUser=false;
                     await dateOController.updateDateO(context, dateO: dateOController.listDateUpcoming[index]);
                  }
                }
            ),
          ),
          ListView.builder(
            itemCount: dateOController.listDateComplete.length,
            itemBuilder: (_,index)=>BuildItemDates(
                dateName: dateOController.listDateComplete[index].subjectConsultation,
                lawyerName:  dateOController.getIdUserOrIdLawyer(context,dateOController.listDateComplete[index]),
                date: dateOController.listDateComplete[index].dateTime,
                onTap: (){},
                icon: null,
                iconType: Icons.check_circle_rounded,
                colorIcon2: ColorManager.success,
                onTapIcon: null
            ),
          ),
        ],
      ),
    );
  }
}
