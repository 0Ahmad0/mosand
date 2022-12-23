import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mosand/translations/locale_keys.g.dart';
import 'package:mosand/view/resourse/color_manager.dart';
import 'package:mosand/view/resourse/const_manager.dart';
import 'package:mosand/view/resourse/style_manager.dart';
import 'package:sizer/sizer.dart';

class MyDatesView extends StatelessWidget {
  const MyDatesView({Key? key}) : super(key: key);

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
                  Container(
                    color: Colors.redAccent,
                  ),
                  Container(
                    color: Colors.blueAccent,
                  ),
                  Container(
                    color: Colors.pinkAccent,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
