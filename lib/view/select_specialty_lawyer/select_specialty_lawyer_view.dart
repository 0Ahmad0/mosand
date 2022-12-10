import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:mosand/translations/locale_keys.g.dart';
import 'package:mosand/view/manager/widgets/ShadowContainer.dart';
import 'package:mosand/view/resourse/assets_manager.dart';
import 'package:mosand/view/resourse/color_manager.dart';
import 'package:mosand/view/resourse/const_manager.dart';
import 'package:mosand/view/resourse/values_manager.dart';

class SelectSpecialtyLawyerView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr(LocaleKeys.specialty_lawyer)),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(AppPadding.p12),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2
        ),
        itemBuilder: (context,index)=>SelectSpecialtyLawyerItem(
            index: index,
          image: AssetsManager.logoIMG,
        ),
        itemCount: ConstManager.specialtyLength,
      ),
    );
  }
}

class SelectSpecialtyLawyerItem extends StatefulWidget {
  final int index;
  final String image;

   SelectSpecialtyLawyerItem({super.key, required this.index, required this.image});

  @override
  State<SelectSpecialtyLawyerItem> createState() => _SelectSpecialtyLawyerItemState();
}

class _SelectSpecialtyLawyerItemState extends State<SelectSpecialtyLawyerItem> {
  bool isShow = false;

  @override
  Widget build(BuildContext context) {
    List<String> specialtyLawyer = [
      tr(LocaleKeys.personal_status),
      tr(LocaleKeys.commercial_cases),
      tr(LocaleKeys.labor_disputes),
      tr(LocaleKeys.cybercrime),
      tr(LocaleKeys.real_estate_cases),
      tr(LocaleKeys.inheritance_cases),
      tr(LocaleKeys.criminal_cases),
      tr(LocaleKeys.medical_errors),
      tr(LocaleKeys.zakat_and_tax),
      tr(LocaleKeys.administrative_issues),
    ];
    return ShadowContainer(
      padding: isShow?0.0:8.0,
      margin: 6.0,
      child: Stack(
        children: [
          GestureDetector(
            onTap: (){
              Get.back();
            },
            child: Column(
              children: [
                Expanded(child: Image.asset(AssetsManager.logoIMG)),
                Text(specialtyLawyer[widget.index]),
              ],
            ),
          ),
          Visibility(
            visible: isShow,
            child: Container(
              padding: EdgeInsets.all(AppPadding.p12),
              alignment: Alignment.center,
              width: double.infinity,
              height: double.infinity,
              child: Flexible(child: Text("HelloHelloHelloHelloHelloHelloHelloHelloHelloHello")),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(AppSize.s8)
              ),
            ),
          ),
          IconButton(onPressed: (){
            isShow = !isShow;
            setState(() {

            });
          },icon: Icon(
              isShow?Icons.remove_circle:Icons.info_outline),
          color: isShow?ColorManager.white:Theme.of(context).primaryColor,),
        ],
      ),
    );
  }
}
