import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';

import '../../controller/provider/auth_provider.dart';
import '../../controller/provider/profile_provider.dart';
import '../../model/models.dart';
import '../../model/utils/local/storage.dart';
import '../home/home_view.dart';
import '../login/login_view.dart';
import '../navbar/navbar.dart';
import '../welcome/welcome_view.dart';
import 'widgets/splash_view_body.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(const Duration(seconds: 5), () {

      AuthProvider authProvider= Provider.of<AuthProvider>(context,listen: false);
      ProfileProvider profileProvider= Provider.of<ProfileProvider>(context,listen: false);

      init(context,authProvider,profileProvider);
    });

  }

  init(context,authProvider,profileProvider) async {
    await AppStorage.init();
    //print("f ${Advance.isLogined}");
 ///TODO language
    if(Advance.language){
    //  await context.setLocale(Locale('ar'));
      Get.updateLocale(Locale('ar'));
    }else
    {
     // await context.setLocale(Locale('en'));
      Get.updateLocale(Locale('en'));
    }

    ///end
    if(Advance.isLogined&&Advance.token!=""){
      final result = await authProvider.fetchUser(uid: Advance.uid);
      if(result['status']){
        profileProvider.updateUser(user:User.fromJson(result['body']));
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(
                builder: (ctx) => NavbarView()));
      }else{
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              //  builder: (ctx) => LoginView()));
                builder: (ctx) => WelcomeView()));
      }

    }else{
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => WelcomeView()
            //HomeView()
            // LoginView()
          ));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SplashViewBody());
  }
}
