import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mosand/view/manager/widgets/ShadowContainer.dart';
import 'package:mosand/view/resourse/color_manager.dart';
import 'package:mosand/view/resourse/values_manager.dart';
import 'package:sizer/sizer.dart';

class BuildItemDates extends StatelessWidget {
  final String dateName, lawyerName, date;
  final VoidCallback onTap;
  final IconData? icon, iconType;
  final VoidCallback? onTapIcon;
  final Color colorIcon,colorIcon2;

  const BuildItemDates(
      {super.key,
      required this.dateName,
      required this.lawyerName,
      required this.date,
      required this.onTap,
      required this.icon,
      required this.onTapIcon,
      required this.iconType,
      this.colorIcon = ColorManager.error,
      this.colorIcon2 = ColorManager.lightGray});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: ShadowContainer(
          padding: 0.0,
          color: Theme.of(context).cardColor,
          child: Container(
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(AppSize.s14)),
            child: Column(
              children: [
                ListTile(
                  title: Text(dateName),
                  leading: Icon(Icons.account_box_rounded),
                  trailing: Icon(
                    iconType,
                    size: 25.sp,
                    color: colorIcon2,
                  ),
                ),
                ListTile(
                  title: Text(lawyerName),
                  leading: Icon(Icons.person),
                ),
                ListTile(
                  title: Text('${DateFormat.yMEd().format(DateTime.now())}'),
                  leading: Icon(Icons.date_range),
                  trailing: GestureDetector(
                    onTap: onTapIcon,
                    child: Icon(
                      icon,
                      color: colorIcon,
                      size: 20.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
