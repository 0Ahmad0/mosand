import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mosand/translations/locale_keys.g.dart';
import 'package:mosand/view/resourse/values_manager.dart';
import 'package:sizer/sizer.dart';

import '../resourse/style_manager.dart';
import 'widgets/build_lawyer_item.dart';

class AllLawyersView extends StatelessWidget {
  const AllLawyersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            child: ListView.separated(
              itemCount: 20,
              itemBuilder: (ctx,index)=>BuildLawyerItem(

                lawyerName: "Ahmad Alhariri",
                lawyerSpesification: "Lawyer from france",
                onTap: (){},
              ), separatorBuilder: (_,__)=>const Divider(height: 0.0,),
            ),
          ),
        ],
      ),
    );
  }
}
