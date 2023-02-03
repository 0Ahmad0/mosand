import 'package:animate_do/animate_do.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mosand/translations/locale_keys.g.dart';
import 'package:mosand/view/resourse/assets_manager.dart';
import 'package:mosand/view/resourse/values_manager.dart';
import 'package:sizer/sizer.dart';

import '../../../controller/utils/create_environment_provider.dart';
import '../../../model/utils/consts_manager.dart';
import '../../login/login_view.dart';

class WelcomeViewBody extends StatelessWidget {
  const WelcomeViewBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FadeInDown(
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
          FadeInRightBig(
            child: buildWelcomeButton(context,text:tr(LocaleKeys.user),onTap:(){
              Get.to(()=>LoginView(typeUser: AppConstants.collectionUser,));
            }),
          ),
          FadeInLeftBig(child: buildWelcomeButton(context,text:tr(LocaleKeys.lawyer),onTap:(){
            Get.to(()=>LoginView(typeUser: AppConstants.collectionLawyer,));
          })),
          FadeInRightBig(child: buildWelcomeButton(context,text:tr(LocaleKeys.supervisor),onTap:(){
            // CreateEnvironmentProvider().createAdmins(context);
            Get.to(()=>LoginView(typeUser: AppConstants.collectionAdmin,));
          }))
        ],
      ),
    );
  }

  GestureDetector buildWelcomeButton(BuildContext context,{text,onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
          padding: const EdgeInsets.all(AppPadding.p20),
          margin: const EdgeInsets.all(AppMargin.m12),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(AppSize.s50)
              ),
          child: Text(text,style: Theme.of(context).textTheme.bodyText1,)),
    );
  }
}
