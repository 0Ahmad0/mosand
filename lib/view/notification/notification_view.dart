import 'package:animate_do/animate_do.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mosand/translations/locale_keys.g.dart';
import 'package:mosand/view/manager/widgets/ShadowContainer.dart';
import 'package:mosand/view/resourse/assets_manager.dart';
import 'package:mosand/view/resourse/values_manager.dart';
import 'package:sizer/sizer.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.all(AppPadding.p10),
        itemBuilder: (context, index) => BuildNotification(
              index: index,
              notificationName: 'notification',
            ),
        itemCount: 50);
  }
}

class BuildNotification extends StatelessWidget {
  final int index;
  final String notificationName;

  const BuildNotification(
      {super.key, required this.index, required this.notificationName});

  @override
  Widget build(BuildContext context) {
    return SlideInDown(
      duration: Duration(milliseconds: (index + 1) * 100),
      child: ShadowContainer(
        color: Theme.of(context).cardColor,
        padding: 0.0,
        child: Container(
          padding: const EdgeInsets.all(AppPadding.p14),
          margin: const EdgeInsets.symmetric(vertical: AppPadding.p4),
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(.2),
              borderRadius: BorderRadius.circular(AppSize.s8)),
          child: Column(
            children: [
              ListTile(
                leading: Icon(
                  Icons.notifications,
                  color: Theme.of(context).cardColor,
                  size: 25.sp,
                ),
                title: Text(notificationName),
                trailing: IconButton(
                  onPressed: (){},
                  icon: Icon(Icons.delete),
                ),
              )
            ],
          ),
        ),
        margin: 0.0,
      ),
    );
  }
}

/*
//TODO add if you want
          Container(
            padding: const EdgeInsets.all(AppPadding.p12),
            margin: const EdgeInsets.symmetric(horizontal: AppMargin.m12),
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                shape: BoxShape.circle),
            child:  Icon(
                Icons.favorite ,
                size: AppSize.s30 ,
                color: ColorManager.error
            ),
          ),

 */
