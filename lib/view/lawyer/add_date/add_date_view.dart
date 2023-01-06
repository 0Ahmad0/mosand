import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mosand/model/models.dart';
import 'package:mosand/translations/locale_keys.g.dart';
import 'package:mosand/view/manager/widgets/ShadowContainer.dart';
import 'package:mosand/view/resourse/style_manager.dart';
import 'package:mosand/view/resourse/values_manager.dart';
import 'package:sizer/sizer.dart';

import '../../resourse/const_manager.dart';

class AddDateView extends StatefulWidget {
  @override
  State<AddDateView> createState() => _AddDateViewState();
}

class _AddDateViewState extends State<AddDateView> {
  final _currentDate = DateTime.now();

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

  @override
  Widget build(BuildContext context) {
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (int i = 0; i < datesWeekDay.length; i++)
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
                                        Navigator.of(context).push(
                                          showPicker(
                                            context: context,
                                            value: TimeOfDay.now(),
                                            onChange: (timeChange) {
                                              textController[i
                                                  .toString()]['from'].text =
                                                  timeChange.format(context);
                                              setState(() {});
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
                                        hintText: tr(LocaleKeys.from),
                                        border: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,

                                      ),
                                      onTap: () {
                                        Navigator.of(context).push(
                                          showPicker(
                                            context: context,
                                            value: TimeOfDay.now(),
                                            onChange: (timeChange) {
                                              textController[i
                                                  .toString()]['to'].text =
                                                  timeChange.format(context);
                                              setState(() {});

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
          ],
        ),
      ),
    );
  }
}
