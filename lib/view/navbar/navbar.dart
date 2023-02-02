import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:mosand/model/utils/consts_manager.dart';
import 'package:provider/provider.dart';
import '../../controller/provider/profile_provider.dart';
import '../my_dates/my_dates_view.dart';
import '/view/notification/notification_view.dart';
import '/translations/locale_keys.g.dart';
import '/view/chat/chat_view.dart';
import '/view/home/home_view.dart';
import '/view/navbar/widgets/build_drawer.dart';
import '/view/resourse/color_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../chart/chart_view.dart';

class NavbarView extends StatefulWidget {
  @override
  State<NavbarView> createState() => _NavbarViewState();
}

class _NavbarViewState extends State<NavbarView> {
  late List<Map<String, dynamic>> _screens;
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    ProfileProvider profileProvider= Provider.of<ProfileProvider>(context);
    _screens=[];
    if(profileProvider.user.typeUser.contains(AppConstants.collectionUser))
      _screens.add(
        {
          "title": tr(LocaleKeys.home_page),
          "icon": Icons.home,
          "screen": HomeView(),
        },);
    _screens.addAll( [
      {
        "title": tr(LocaleKeys.my_dates),
        "icon": Icons.date_range,
        "screen": MyDatesView()
      },
      {
        "title": tr(LocaleKeys.chat_page),
        "icon": Icons.chat,
        "screen": ChatView()
      },
      {
        "title": tr(LocaleKeys.notification),
        "icon": Icons.notifications,
        "screen": NotificationView()
      },
    ]);

    return Scaffold(
      drawer: Drawer(
        child: BuildDrawer(),
    ),
      appBar: AppBar(
        title: Text(_screens[_currentIndex]['title']),
        elevation: _currentIndex == 1 ? 0.0 : (_screens.length).toDouble(),
      ),

      body: _screens[_currentIndex]['screen'],

      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: Theme.of(context).primaryColor,
        onTap: (index){
          _currentIndex = index;
          setState(() {

          });
        },
          color: Theme.of(context).primaryColor,
        items: [
          for(int i = 0 ; i < _screens.length ; i++)
            Icon(_screens[i]['icon'],
    color: ColorManager.white,
    )
        ],
      ),
    );
  }
}
