import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../translations/locale_keys.g.dart';
import '../../resourse/font_manager.dart';
import '../../resourse/style_manager.dart';
import '/view/login/widgets/login_view_body.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import '../../login/login_view.dart';
import '/translations/locale_keys.g.dart';
import '/view/manager/widgets/ShadowContainer.dart';
import '/view/manager/widgets/textformfiled_app.dart';
import '/view/resourse/assets_manager.dart';
import '/view/resourse/values_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../manager/widgets/button_app.dart';
import '../../resourse/color_manager.dart';

class SignupViewBody extends StatelessWidget {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final idLawyerController = TextEditingController();
  final passwordController = TextEditingController();
  final genderController = TextEditingController();
  final dateOfBirthController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  RegExp regex =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

  bool validatePassword(String value) {
    return regex.hasMatch(value);
  }
  DateTime _selectedDate = DateTime.now();
  _selectDate(BuildContext context) async {
    var newSelectedDate = await showDatePicker(
      builder: (context, child) {
        return child!;
      },
      context: context,
      initialDate: _selectedDate != null ? _selectedDate : DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2040),
    );

    if (newSelectedDate != null) {
      _selectedDate = newSelectedDate;
      dateOfBirthController
        ..text = DateFormat.yMd().format(_selectedDate)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: dateOfBirthController.text.length,
            affinity: TextAffinity.upstream));
    }
  }
  @override
  Widget build(BuildContext context) {
//    List<String> gender = [tr(LocaleKeys.female)];
    return SafeArea(
      child: Center(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
//              FadeInRightBig(
//                child: Container(
//                  width: 35.w,
//                  height: 35.w,
//                  decoration: BoxDecoration(
//                      shape: BoxShape.circle,
//                      image: DecorationImage(
//                          image: AssetImage(AssetsManager.logoIMG)
//                      )
//                  ),
//                ),
//              ),
//              const SizedBox(height: AppSize.s10,),
                FadeInRight(
                  child: ShadowContainer(
                      padding: AppPadding.p20,
                      color: Theme.of(context).cardColor,
                      shadowColor:
                          Theme.of(context).textTheme.bodyMedium!.color!,
                      child: Column(
                        children: [
                          FadeInLeftBig(
                            child: TextFiledApp(
                                controller: nameController,
                                iconData: Icons.person,
                                hintText: tr(LocaleKeys.full_name)),
                          ),
                          const SizedBox(
                            height: AppSize.s10,
                          ),
                          FadeInLeftBig(
                            child: TextFiledApp(
                              controller: emailController,
                              hintText: tr(LocaleKeys.email_address),
                              iconData: Icons.email,
                              validator: (String? val) {
                                if (!val!.isEmail)
                                  return tr(LocaleKeys.enter_valid_email);
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(
                            height: AppSize.s10,
                          ),
                          FadeInLeftBig(
                            child: TextFiledApp(
                              controller: phoneController,
                              hintText: tr(LocaleKeys.mobile_number),
                              iconData: Icons.phone,
                              keyboardType: TextInputType.phone,
                              validator: (String? val) {
                                if (!val!.isPhoneNumber)
                                  return tr(
                                      LocaleKeys.enter_valid_phone_number);
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(
                            height: AppSize.s10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: FadeInLeftBig(
                                  child: DropdownButtonFormField(
                                    items: [
                                      tr(LocaleKeys.female_g),
                                      tr(LocaleKeys.male_g)
                                    ]
                                        .map((e) => DropdownMenuItem(
                                              child: Text(e),
                                              value: e,
                                            ))
                                        .toList(),
                                    onChanged: (String? value) {
                                      genderController.text = value.toString();
                                    },
                                    validator: (String? val){
                                      if(val == null){
                                        return tr(LocaleKeys.field_required);
                                  }
                                  },
                                    isExpanded: true,
                                    decoration: InputDecoration(
                                      hintText: tr(LocaleKeys.gender),
                                      hintStyle: TextStyle(
                                          fontSize: SizerUtil.width / 32),
                                      contentPadding:
                                          const EdgeInsets.all(AppPadding.p16),
                                      prefixIcon: Icon(Icons.boy),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: AppSize.s10,
                              ),
                              Expanded(
                                child: FadeInLeftBig(
                                  child: TextFiledApp(
                                    onTap: ()async{
                                      await _selectDate(context);
                                    },
                                    readOnly: true,
                                    controller: dateOfBirthController,
                                    hintText: tr(LocaleKeys.data_of_birth),
                                    iconData: Icons.date_range,
                                    keyboardType: TextInputType.datetime,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: AppSize.s10,
                          ),
                          FadeInLeftBig(
                            child: TextFiledApp(
                              controller: idLawyerController,
                              hintText: tr(LocaleKeys.license),
                              iconData: Icons.numbers,
                              keyboardType: TextInputType.phone,
                              validator: (String? val) {
                                if (val!.trim().isEmpty)
                                  return tr(LocaleKeys.enter_valid_id_license);
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(
                            height: AppSize.s10,
                          ),
                          FadeInLeftBig(
                            child: TextFiledApp(
                              controller: passwordController,
                              obscureText: true,
                              suffixIcon: true,
                              hintText: tr(LocaleKeys.password),
                              iconData: Icons.lock,
                              validator: (String? val) {
                                if (val!.length < 8 && !validatePassword(val!))
                                  return tr(LocaleKeys.enter_strong_password);
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(
                            height: AppSize.s10,
                          ),
                          FadeInLeftBig(
                            child: TextFiledApp(
                              controller: confirmPasswordController,
                              obscureText: true,
                              suffixIcon: true,
                              hintText: tr(LocaleKeys.confirm_password),
                              iconData: Icons.lock,
                              validator: (String? val) {
                                if (confirmPasswordController.text
                                        .compareTo(passwordController.text) !=
                                    0)
                                  return tr(LocaleKeys.enter_matched_password);
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(
                            height: AppSize.s10,
                          ),
                          FadeInLeftBig(
                            child: ButtonApp(
                                text: tr(LocaleKeys.signup),
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {}
                                }),
                          ),
                          const SizedBox(
                            height: AppSize.s4,
                          ),
                          FadeInLeftBig(
                            child: TextButton(
                                onPressed: () {
                                  Get.off(LoginView());
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(tr(LocaleKeys.already_have_account)),
                                    Text(tr(LocaleKeys.login)),
                                  ],
                                )),
                          )
                        ],
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
