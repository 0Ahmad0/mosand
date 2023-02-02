import 'package:cached_network_image/cached_network_image.dart';
import 'package:mosand/view/lawyer/add_date/add_date_view.dart';
import 'package:mosand/view/lawyer/add_post/add_post_view.dart';
import 'package:mosand/view/resourse/values_manager.dart';
import 'package:mosand/view/show_posts/show_posts_view.dart';
import 'package:provider/provider.dart';
import '../../../controller/provider/profile_provider.dart';
import '../../../model/utils/consts_manager.dart';
import '../../../model/utils/local/storage.dart';
import '../../app/picture/cach_picture_widget.dart';
import '../../app/picture/profile_picture_widget.dart';
import '../../welcome/welcome_view.dart';

import '/view/manager/widgets/custom_listtile.dart';
import '/view/profile/profile_view.dart';
import '/view/setting/setting_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../translations/locale_keys.g.dart';
import '../../resourse/color_manager.dart';
import '../../resourse/style_manager.dart';

class BuildDrawer extends StatelessWidget {
  const BuildDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var profileProvider;
    return   ChangeNotifierProvider<ProfileProvider>.value(
    value: Provider.of<ProfileProvider>(context),
    child: Consumer<ProfileProvider>(
    builder: (context, value, child) =>
        Column(
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                  color: Theme
                      .of(context)
                      .primaryColor
              ),
              margin: EdgeInsets.zero,
              accountName: Text(
              //  tr(LocaleKeys.full_name),
                 value.user.name,
                style: getRegularStyle(
                  color: ColorManager.white,
                ),
              ),
              accountEmail: Text(
                //tr(LocaleKeys.email_address),
                 value.user.email,
                style: getLightStyle(
                  color: ColorManager.white,
                ),
              ),
              currentAccountPicture:
                  /*
              (value.user.photoUrl == null||value.user.photoUrl =="")?
          WidgetProfilePicture(
            name: value.user.name,
            radius: 30.w,

          ):*/
              GestureDetector(
                onTap: ()=>Get.to(()=>ProfileView()),
                child: Container(
                    decoration: BoxDecoration(
                      color: Theme
                          .of(context)
                          .cardColor,
                      shape: BoxShape.circle,
                    ),
                    child: ClipOval(
                      child:
                      CacheNetworkImage(
                        photoUrl: value.user.photoUrl,
                        width: 30.w,
                        height: 30.w,
                        waitWidget:  CircularProgressIndicator(),
                        errorWidget: WidgetProfilePicture(
                          name: value.user.name,
                          radius: 30.w,
                          backgroundColor: ColorManager.secondaryColor,
                          textColor: ColorManager.primaryColor,
                        ),
                      ),
                      /*CachedNetworkImage(
                        fit: BoxFit.fill,
                        width: 30.w,
                        height: 30.h,
                        imageUrl:
                        // "${AppUrl.baseUrlImage}${widget.restaurant.imageLogo!}",
                        "https://live.staticflickr.com/1928/44477856474_882848622a_n.jpg",
                        imageBuilder: (context, imageProvider) =>
                            Container(
                              decoration: BoxDecoration(
                                color: Theme
                                    .of(context)
                                    .primaryColor,
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                  //    colorFilter: ColorFilter.mode(Colors.red, BlendMode.colorBurn)
                                ),
                              ),
                            ),
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            Icon(Icons.error),
                      ),*/
                    )
                ),
              ),
            ),
            CustomListTile(
                onTap: ()=>Get.to(()=>SettingView()),
                title: tr(LocaleKeys.setting), icon: Icons.settings),
            Divider(
              height: 0.0,
              color: Theme.of(context).primaryColor.withOpacity(.5),
            ),
            CustomListTile(
                onTap: ()=>Get.to(()=>ProfileView()),
                title: tr(LocaleKeys.profile), icon: Icons.person),
           if(value.user.typeUser.contains(AppConstants.collectionLawyer))
          customTileLawyer(context),
            Divider(
              height: 0.0,
              color: Theme.of(context).primaryColor.withOpacity(.5),
            ),
            CustomListTile(
                onTap: ()=>Get.to(()=>ShowPostsView()),
                title: tr(LocaleKeys.posts), icon: Icons.book),
            Divider(
              height: 0.0,
              color: Theme.of(context).primaryColor.withOpacity(.5),
            ),
            CustomListTile(
              onTap: (){
                AppStorage.depose();
                Get.to(()=>WelcomeView());
                //  exit(0);
              },
              icon: Icons.logout,
              title: tr(LocaleKeys.exit),
            ),
            Spacer(),
            GestureDetector(
              onTap: (){},
              child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                padding: EdgeInsets.all(AppPadding.p14),
                margin: EdgeInsets.all(AppPadding.p12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSize.s50),
                  color: Theme.of(context).primaryColor,
                ),
                child: Text(tr(LocaleKeys.exit),style: getRegularStyle(
                    color: Theme.of(context).cardColor,
                    fontSize: 16.sp
                ),),
              ),
            )
          ],
        )
    ));
  }
  customTileLawyer(BuildContext context){
    return ListBody(
      children: [
        Divider(
          height: 0.0,
          color: Theme.of(context).primaryColor.withOpacity(.5),
        ),
        CustomListTile(
            onTap: ()=>Get.to(()=>AddDateView()),
            title: tr(LocaleKeys.add_date), icon: Icons.date_range),
        Divider(
          height: 0.0,
          color: Theme.of(context).primaryColor.withOpacity(.5),
        ),
        CustomListTile(
            onTap: ()=>Get.to(()=>AddPostView()),
            title: tr(LocaleKeys.add_post), icon: Icons.post_add),
      ],
    );
  }
}
