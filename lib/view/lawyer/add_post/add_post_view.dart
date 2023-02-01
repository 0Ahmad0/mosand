import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mosand/controller/Internship_controller.dart';
import 'package:mosand/controller/provider/profile_provider.dart';
import 'package:mosand/model/models.dart';
import 'package:mosand/translations/locale_keys.g.dart';
import 'package:mosand/view/manager/widgets/button_app.dart';
import 'package:provider/provider.dart';

import '../../resourse/values_manager.dart';
class AddPostView extends StatelessWidget {
  final postController = TextEditingController();
  final priceController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late InternshipController internshipController;
  @override
  Widget build(BuildContext context) {
    internshipController=InternshipController(context: context);
    final ProfileProvider profileProvider=Provider.of<ProfileProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(tr(LocaleKeys.add_post)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppPadding.p12),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                validator: (String? val){
                  if(val!.trim().isEmpty) return tr(LocaleKeys.field_required);
                  return null;
                },
                controller: postController,
                decoration: InputDecoration(
                  hintText: tr(LocaleKeys.add_post),
                ),
                minLines: 4,
                maxLines: 8,
              ),
              const SizedBox(height: AppSize.s20,),
              TextFormField(
                validator: (String? val){
                  if(val!.trim().isEmpty) return tr(LocaleKeys.field_required);
                  return null;
                },
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: tr(LocaleKeys.price),
                ),
              ),
              Spacer(),
              ButtonApp(text: tr(LocaleKeys.add_post), onPressed: () async {
                if(_formKey.currentState!.validate()){
                  await internshipController.addInternship(context,
                      internship: Internship(internshipOpportunity: postController.text, idLawyer: profileProvider.user.id, price: priceController.text));
                }
              })
            ],
          ),
        ),
      ),
    );
  }
}
