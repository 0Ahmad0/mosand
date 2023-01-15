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
    List<String> specialtyDescription = [
      tr(LocaleKeys.personal_status_d),
      tr(LocaleKeys.commercial_issues_d),
      tr(LocaleKeys.labor_disputes_d),
      tr(LocaleKeys.information_crimes_d),
      tr(LocaleKeys.real_estate_cases_d),
      tr(LocaleKeys.inheritance_issues_d),
      tr(LocaleKeys.criminal_cases_d),
      tr(LocaleKeys.medical_errors_d),
      tr(LocaleKeys.zakat_tax_d),
      tr(LocaleKeys.administrative_cases_d),
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
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(child:  Image.asset('assets/images/${widget.index+1}.png')),
                Text(specialtyLawyer[widget.index],textAlign: TextAlign.center,),
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
              child: Flexible(child: Text(specialtyDescription[widget.index],overflow: TextOverflow.ellipsis,)),
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
