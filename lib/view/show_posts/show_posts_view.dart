import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mosand/controller/provider/process_provider.dart';
import 'package:mosand/controller/provider/profile_provider.dart';
import 'package:mosand/model/models.dart';
import 'package:mosand/translations/locale_keys.g.dart';
import 'package:mosand/view/manager/widgets/ShadowContainer.dart';
import 'package:mosand/view/resourse/color_manager.dart';
import 'package:mosand/view/resourse/style_manager.dart';
import 'package:mosand/view/resourse/values_manager.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../controller/Internship_controller.dart';
import '../../model/utils/const.dart';
import '../../model/utils/consts_manager.dart';

class ShowPostsView extends StatefulWidget {
   ShowPostsView({Key? key}) : super(key: key);

  @override
  State<ShowPostsView> createState() => _ShowPostsViewState();
}

class _ShowPostsViewState extends State<ShowPostsView> {
   late InternshipController internshipController;
   late ProfileProvider profileProvider;
   var getListInternships;
   @override
   void initState() {
     profileProvider = Provider.of<ProfileProvider>(context, listen: false);
     getListInternshipsFun();
     super.initState();
   }

   getListInternshipsFun() async {
     getListInternships = FirebaseFirestore.instance
         .collection(AppConstants.collectionInternship)
         .snapshots();
     return getListInternships;
   }
  @override
  Widget build(BuildContext context) {
    internshipController=InternshipController(context: context);
    profileProvider = Provider.of<ProfileProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(tr(LocaleKeys.posts)),
      ),
      body: StreamBuilder<QuerySnapshot>(
        //prints the messages to the screen0
          stream: getListInternships,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return
                Const.SHOWLOADINGINDECATOR();

            }
            else if (snapshot.connectionState ==
                ConnectionState.active) {
              if (snapshot.hasError) {
                return const Text('Error');
              } else if (snapshot.hasData) {
                Const.SHOWLOADINGINDECATOR();
                internshipController.internshipProvider.internships=Internships.fromJson(snapshot.data?.docs);

                return ListView.builder(
                  itemCount: internshipController.internshipProvider.internships.listInternship.length,
                  itemBuilder: (_, index) => BuildPostItem(index: index,internshipController: internshipController,),
                );
                /// }));
              } else {
                return const Text('Empty data');
              }
            }
            else {
              return Text('State: ${snapshot.connectionState}');
            }
          }),
    );
  }
}

class BuildPostItem extends StatelessWidget {
  final int index;
  final InternshipController internshipController;
  late ProfileProvider profileProvider;
  late ProcessProvider processProvider;
   BuildPostItem({super.key, required this.index, required this.internshipController});

  @override
  Widget build(BuildContext context) {
    profileProvider = Provider.of<ProfileProvider>(context);
    processProvider = Provider.of<ProcessProvider>(context);
    return ShadowContainer(
      child: Container(
        padding: const EdgeInsets.all(AppPadding.p12),
        margin: const EdgeInsets.symmetric(vertical: AppMargin.m4),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(Icons.person),
                  title: Text(
                    internshipController.internshipProvider.internships.listInternship[index].internshipOpportunity
                    //  'Post Name'
                  ),
                  subtitle:Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: AppSize.s10,),
                      processProvider.widgetNameUser(context, idUser:internshipController.internshipProvider.internships.listInternship[index].idLawyer),
                      const SizedBox(height: AppSize.s10,),
                      Text(
                       // '${index + 1 * 12.5}  ' + tr(LocaleKeys.sr),
                        '${internshipController.internshipProvider.internships.listInternship[index].price}  ' + tr(LocaleKeys.sr),
                        style: getRegularStyle(
                            color: ColorManager.error, fontSize: 16.sp),
                      ),
                    ],
                  )
                ),

              ],
            ),
            Positioned(
              left: (Advance.language)?0:null,
              bottom: 0,
              right: (!Advance.language)?0:null,
              child:
              (!profileProvider.user.typeUser.contains(AppConstants.collectionLawyer))?
              FloatingActionButton(

                onPressed: () {
                  Get.snackbar('invite Internship', 'done join Internship ${internshipController.internshipProvider.internships.listInternship[index].internshipOpportunity}');
                },
                child: Icon(Icons.send),
              ):
              FloatingActionButton(
                backgroundColor: ColorManager.error,
                onPressed: () async {
                  await internshipController.deleteInternship(context, internship: internshipController.internshipProvider.internships.listInternship[index]);
                },
                child: Icon(Icons.delete),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
