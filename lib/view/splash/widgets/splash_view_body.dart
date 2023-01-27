import 'package:animate_do/animate_do.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mosand/translations/locale_keys.g.dart';
import 'package:mosand/view/resourse/color_manager.dart';
import 'package:mosand/view/resourse/const_manager.dart';
import 'package:mosand/view/resourse/style_manager.dart';
import 'package:mosand/view/welcome/welcome_view.dart';
import 'package:sizer/sizer.dart';
import '../../login/login_view.dart';

import '/view/resourse/assets_manager.dart';
import '/view/resourse/values_manager.dart';

class SplashViewBody extends StatelessWidget {
  const SplashViewBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
 //   Future.delayed(Duration(seconds: 3),()=>Get.off(()=>WelcomeView()));
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FadeInDownBig(
            child: Container(
              width: 50.w,
              height: 50.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage(AssetsManager.logoIMG)
                )
              ),
            ),
          ),
          const SizedBox(height: AppSize.s10,),
          FadeInDownBig(
            child: Text(tr(LocaleKeys.mosand),style: getBoldStyle(
                color: Theme.of(context).primaryColor,
              fontSize: 32.sp
            ),),
          ) ,
          FadeInDownBig(
            child: Flash(
              delay: Duration(milliseconds: ConstManager.splashTextDelay),
              child: Text(tr(LocaleKeys.for_legal_advice),style: getRegularStyle(
                  color: Theme.of(context).primaryColor,
                fontSize: 24.sp
              ),),
            ),
          )
        ],
      ),
    );
  }
}
