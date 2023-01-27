import 'package:flutter/material.dart';

import '../../controller/auth_controller.dart';
import 'widgets/sign_up_view_body.dart';

class SignupView extends StatelessWidget {
   SignupView({Key? key,required this.typeUser}) : super(key: key);
  String typeUser;
  @override
  Widget build(BuildContext context) {
    AuthController authController=AuthController(context: context);
    return Scaffold(
      body: SignupViewBody(authController:authController,typeUser: typeUser,),
    );
  }
}
