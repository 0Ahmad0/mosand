import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mosand/controller/home_controller.dart';
import 'package:mosand/translations/locale_keys.g.dart';
import 'package:mosand/view/resourse/values_manager.dart';
import 'package:sizer/sizer.dart';

import '../../model/utils/const.dart';
import '../resourse/style_manager.dart';
import 'widgets/build_lawyer_item.dart';

class AllLawyersView extends StatelessWidget {
   AllLawyersView({Key? key}) : super(key: key);
  late HomeController homeController;
  @override
  Widget build(BuildContext context) {
    homeController=HomeController(context: context);
    return Scaffold(
      appBar: AppBar(
        title: Text(tr(LocaleKeys.all_lawyers)),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p12),
            child: Text(tr(LocaleKeys.select_lawyer),style: getBoldStyle(
                color: Theme.of(context).textTheme.labelMedium!.color,
                fontSize: 24.sp
            ),),
          ),
          Expanded(
            child:
            FutureBuilder(
            //prints the messages to the screen0
              future: homeController.fetchLawyer(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return
                    (HomeController.lawyers.users.length>0)?
                        buildAllLawyer():
                    Const.SHOWLOADINGINDECATOR();

                }
           {
                  if (snapshot.hasError) {
                    return const Text('Error');
                  } else if (snapshot.hasData) {
                   // Const.SHOWLOADINGINDECATOR();

                    return buildAllLawyer();
                    /// }));
                  } else {
                    return const Text('Empty data');
                  }
                }

              }),
           )
        ],
      ),
    );
  }
   buildAllLawyer(){
    return ListView.separated(
        itemCount: HomeController.lawyers.users.length,
        itemBuilder: (ctx,index)=>BuildLawyerItem(

          lawyerName: '${HomeController.lawyers.users[index].name}', //"Ahmad Alhariri",
          lawyerSpesification: "Lawyer from france\t${HomeController.lawyers.users[index].gender}",
          onTap: (){
            Get.back(result: HomeController.lawyers.users[index]);
          },
        ), separatorBuilder: (_,__)=>const Divider(height: 0.0,),
      );
   }
}
