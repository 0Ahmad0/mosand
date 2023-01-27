import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '/view/resourse/style_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../view/resourse/color_manager.dart';
import '../../view/resourse/values_manager.dart';
import 'app_sizer.dart';

class Const{
  static LOADIG(context){
    Get.dialog(
        Center(
          child: Container(
              alignment: Alignment.center,
              width: AppSizer.getW(context) * 0.2,
              height: AppSizer.getW(context) * 0.2,
              decoration: BoxDecoration(
                  color: ColorManager.white,
                  borderRadius: BorderRadius.circular(AppSize.s8)),
              child: LoadingAnimationWidget.inkDrop(
                  color: ColorManager.primaryColor,
                  size: AppSizer.getW(context) * 0.1)),
        ),
        barrierDismissible: false
    );
  }



  static TOAST(BuildContext context,{String textToast = "This Is Toast"}){
    showToast(
        textToast,
        context: context,
        animation:StyledToastAnimation.fadeScale,
        textStyle: getRegularStyle(color: ColorManager.white)
    );

  }



  static SHOWLOADINGINDECATOR(){
    return Center(
      child: CircularProgressIndicator(
      ),
    );
  }

}