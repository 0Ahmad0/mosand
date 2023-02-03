import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mosand/controller/date_controller.dart';
import 'package:mosand/controller/notification_controller.dart';
import 'package:mosand/translations/locale_keys.g.dart';
import 'package:mosand/view/manager/widgets/ShadowContainer.dart';
import 'package:mosand/view/resourse/assets_manager.dart';
import 'package:mosand/view/resourse/values_manager.dart';
import 'package:sizer/sizer.dart';

import '../../model/models.dart';
import '../../model/utils/const.dart';

class NotificationView extends StatelessWidget {
   NotificationView({Key? key}) : super(key: key);
  late NotificationController notificationController;
  @override
  Widget build(BuildContext context) {
    notificationController=NotificationController(context: context);
    return StreamBuilder<QuerySnapshot>(
      //prints the messages to the screen0
        stream: notificationController.dateOController.fetchDateOsByUserOrLawyerStream(context),
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
                notificationController.dateOController.dateOProvider.dateOs=DateOs.fromJson(snapshot.data!.docs);
                notificationController.processNotification(context, notificationController.dateOController.dateOProvider.dateOs.listDateO);
              }
              return (notificationController.listNotification.length>0)?buildNotificationViews(context,notificationController):SvgPicture.asset(AssetsManager.noNotificationIMG);
              /// }));
            } else {
              return const Text('Empty data');
            }
          }
          else {
            return Text('State: ${snapshot.connectionState}');
          }
        });
  }
   buildNotificationViews(BuildContext context,NotificationController notificationController){
     return ListView.builder(
         padding: const EdgeInsets.all(AppPadding.p10),
         itemBuilder: (context, index) => BuildNotification(
             notificationController: notificationController,
           index: index,
           notificationName: notificationController.listNotification[index]['message'],
           dateO:notificationController.listNotification[index]['dateO']
         ),
         itemCount: notificationController.listNotification.length);
   }
}

class BuildNotification extends StatelessWidget {
  final int index;
  final String notificationName;
  final DateO dateO;
  final NotificationController notificationController;
  const BuildNotification(
      {super.key, required this.index,required this.dateO, required this.notificationName, required this.notificationController});

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
                subtitle: Text('${DateFormat('MM/dd/yyyy hh:mm a').format(dateO.dateTime)}'),
                trailing: IconButton(
                  onPressed: () async {
                   await notificationController.deleteNotification(context, dateO);
                  },
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
