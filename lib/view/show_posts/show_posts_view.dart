import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mosand/translations/locale_keys.g.dart';
import 'package:mosand/view/manager/widgets/ShadowContainer.dart';
import 'package:mosand/view/resourse/color_manager.dart';
import 'package:mosand/view/resourse/style_manager.dart';
import 'package:mosand/view/resourse/values_manager.dart';
import 'package:sizer/sizer.dart';

class ShowPostsView extends StatelessWidget {
  const ShowPostsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr(LocaleKeys.posts)),
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (_, index) => BuildPostItem(index: index),
      ),
    );
  }
}

class BuildPostItem extends StatelessWidget {
  final int index;

  const BuildPostItem({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return ShadowContainer(
      child: Container(
        padding: const EdgeInsets.all(AppPadding.p12),
        margin: const EdgeInsets.symmetric(vertical: AppMargin.m4),
        child: Stack(
          children: [
            Positioned(
              left: 0,
              bottom: 0,
              child: FloatingActionButton(
                onPressed: () {},
                child: Icon(Icons.send),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(Icons.person),
                  title: Text('Post Name'),
                  subtitle:Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: AppSize.s10,),
                      Text('Lawyer Name $index'),
                      const SizedBox(height: AppSize.s10,),
                      Text(
                        '${index + 1 * 12.5}  ' + tr(LocaleKeys.sr),
                        style: getRegularStyle(
                            color: ColorManager.error, fontSize: 16.sp),
                      ),
                    ],
                  )
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}
