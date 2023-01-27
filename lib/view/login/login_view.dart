import '../../controller/auth_controller.dart';
import '/view/login/widgets/login_view_body.dart';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
   LoginView({Key? key,required this.typeUser}) : super(key: key);
   String typeUser;
  @override
  Widget build(BuildContext context) {
    AuthController authController=AuthController(context: context);
    return Scaffold(
      body: LoginViewBody(typeUser:typeUser,authController: authController),
    );
  }
}
