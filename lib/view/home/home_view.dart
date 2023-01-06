import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:mosand/view/all_lawyers/all_lawyers_view.dart';
import 'package:mosand/view/manager/widgets/button_app.dart';
import '/view/manager/widgets/textformfiled_app.dart';
import '/view/resourse/style_manager.dart';
import '/view/select_specialty_lawyer/select_specialty_lawyer_view.dart';
import 'package:sizer/sizer.dart';

import '/translations/locale_keys.g.dart';
import '/view/resourse/values_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';


class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          readOnly: true,
          onTap: (){
            Get.to(()=>SelectSpecialtyLawyerView())!.then((value) {
              print(value);
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
          iconData: Icons.subject,
          hintText: tr(LocaleKeys.subject_consultation),
        ),
        const SizedBox(height: AppSize.s10,),
        Text(tr(LocaleKeys.telephone_consultation_schedule),style: getBoldStyle(
            color: Theme.of(context).textTheme.labelMedium!.color,
            fontSize: 24.sp
        ),),
        Text(tr(LocaleKeys.please_choose_time_lawyer_to_contact_you)),
        const SizedBox(height: AppSize.s10,),
        DatePicker(
          DateTime.now(),
          width: 20.w,
          height: 15.h,
          initialSelectedDate: DateTime.now(),
          selectionColor: Theme.of(context).primaryColor,
          locale: context.locale.toString(),
          onDateChange: (date) {
            print(date);
          },
        ),
        const SizedBox(height: AppSize.s10,),
        Text(tr(LocaleKeys.morning),style: getBoldStyle(
            color: Theme.of(context).textTheme.labelMedium!.color,
            fontSize: 24.sp
        ),),
        Wrap(
          alignment: WrapAlignment.center,
          children: [
            for(int i =0 ; i < 3;i++)
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: AppMargin.m4),
                    child: Chip(
                      label: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('$i AM'),
                          const SizedBox(width: 5,),
                          Icon(Icons.access_time_filled_sharp)
                        ],
                      ),

              ),
                  )
          ],
        ),
        Text(tr(LocaleKeys.evening),style: getBoldStyle(
            color: Theme.of(context).textTheme.labelMedium!.color,
            fontSize: 24.sp
        ),),
        Wrap(
          alignment: WrapAlignment.center,
          children: [
            for(int i =0 ; i < 3;i++)
              Container(
                margin: const EdgeInsets.symmetric(horizontal: AppMargin.m4),
                child: Chip(
                  label: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('$i AM'),
                      const SizedBox(width: 5,),
                      Icon(Icons.access_time_filled_sharp)
                    ],
                  ),

                ),
              )
          ],
        ),
        const SizedBox(height: AppSize.s10,),
        ButtonApp(text: tr(LocaleKeys.next), onPressed: (){
          Get.to(()=>AllLawyersView());
        })
      ],
    );
  }
}