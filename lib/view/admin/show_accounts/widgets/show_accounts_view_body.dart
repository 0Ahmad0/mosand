
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mosand/controller/home_controller.dart';
import 'package:mosand/controller/lawyer_accounts_controller.dart';
import 'package:mosand/translations/locale_keys.g.dart';
import 'package:mosand/view/manager/widgets/ShadowContainer.dart';
import 'package:mosand/view/manager/widgets/button_app.dart';
import 'package:mosand/view/resourse/color_manager.dart';
import 'package:mosand/view/resourse/values_manager.dart';
import 'package:provider/provider.dart';

import '../../../../controller/provider/profile_provider.dart';
import '../../../../model/models.dart';
import '../../../../model/utils/const.dart';
import '../../../../model/utils/consts_manager.dart';

class ShowAccountsViewBody extends StatefulWidget {

  @override
  State<ShowAccountsViewBody> createState() => _ShowAccountsViewBodyState();
}

class _ShowAccountsViewBodyState extends State<ShowAccountsViewBody> {
  var getLawyers;
  late ProfileProvider profileProvider;
  late LawyerAccountsController lawyerAccountsController;
  @override
  void initState() {
    profileProvider = Provider.of<ProfileProvider>(context, listen: false);

    getLawyersFun();
    super.initState();
  }

  getLawyersFun() {
    getLawyers = LawyerAccountsController().fetchLawyersStream();
    return getLawyers;
  }
  @override
  Widget build(BuildContext context) {
    lawyerAccountsController=LawyerAccountsController();
    return StreamBuilder<QuerySnapshot>(
      //prints the messages to the screen0
        stream: getLawyers,
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
              if(snapshot.data!.docs!.length>0){
                lawyerAccountsController.lawyers=Users.fromJson(snapshot.data!.docs!);
              }

              return ListView.builder(
                itemCount: lawyerAccountsController.lawyers.users.length,
                itemBuilder: (_,index)=>BuildShowAccountItem(index:index,lawyer:lawyerAccountsController.lawyers.users[index]),
              );
              /// }));
            } else {
              return const Text('Empty data');
            }
          }
          else {
            return Text('State: ${snapshot.connectionState}');
          }
        });
  }
}

class BuildShowAccountItem extends StatelessWidget {
  final int index;
  final User lawyer;
   BuildShowAccountItem({super.key, required this.index, required this.lawyer});

  @override
  Widget build(BuildContext context) {
    return ShadowContainer(
      child: Column(
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(lawyer.name),
            subtitle: Text(lawyer.active?LocaleKeys.active:LocaleKeys.non_active),

            trailing: Icon(Icons.circle_rounded,color: !lawyer.active?ColorManager.error:ColorManager.success,),
          ),
          ButtonApp(text: 'text', onPressed: () async {
            await LawyerAccountsController().changeStateUser(context, user: lawyer);
          })
        ],
      ),
    );
  }
}
