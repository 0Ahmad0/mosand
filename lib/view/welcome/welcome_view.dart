import 'package:flutter/material.dart';

import 'widgets/welcome_view_body.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WelcomeViewBody(),
    );
  }
}
