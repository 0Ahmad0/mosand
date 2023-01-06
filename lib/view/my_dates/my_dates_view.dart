import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mosand/translations/locale_keys.g.dart';
import 'package:mosand/view/my_dates/widgets/build_item_dates.dart';
import 'package:mosand/view/resourse/color_manager.dart';
import 'package:mosand/view/resourse/const_manager.dart';
import 'package:mosand/view/resourse/style_manager.dart';
import 'package:sizer/sizer.dart';

class MyDatesView extends StatelessWidget {
  DateTime selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
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
            Expanded(
              child: TabBarView(
                children: [
                ListView.builder(
                  itemCount: 10,
                  itemBuilder: (_,index)=>BuildItemDates(
                      dateName: "dateName",
                      lawyerName: "lawyerName",
                      date: "date",
                      onTap: (){},
                      icon: Icons.delete_sweep,
                      iconType: Icons.hourglass_top,
                      onTapIcon: (){
                        AwesomeDialog(
                            context: context,
                          dialogType: DialogType.error,
                          title: tr(LocaleKeys.this_item_will_be_deleted),
                          desc: tr(LocaleKeys.are_you_sure),
                          btnOkOnPress: (){},
                          btnCancelOnPress: (){},
                          btnOkText: tr(LocaleKeys.ok),
                          btnCancelText: tr(LocaleKeys.cancel),
                        ).show();
                      }
                  ),
                ),
                ListView.builder(
                  itemCount: 10,
                  itemBuilder: (_,index)=>BuildItemDates(
                      dateName: "dateName",
                      lawyerName: "lawyerName",
                      date: "date",
                      onTap: (){
                   
                      },
                      icon: Icons.edit_calendar,
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
                        }
                      }
                  ),
                ),
                ListView.builder(
                  itemCount: 10,
                  itemBuilder: (_,index)=>BuildItemDates(
                      dateName: "dateName",
                      lawyerName: "lawyerName",
                      date: "date",
                      onTap: (){},
                      icon: null,
                      iconType: Icons.check_circle_rounded,
                      colorIcon2: ColorManager.success,
                      onTapIcon: null
                  ),
                ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
