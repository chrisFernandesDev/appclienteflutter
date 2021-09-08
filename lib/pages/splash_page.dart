import 'package:appclienteflutter/controllers/user_controllers.dart';
import 'package:appclienteflutter/widgets/splash_loading_widget.dart';

import 'home_page.dart';
import 'login_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserController>(
      builder: (context, userController, child) {
        switch (userController.authState) {
          case AuthState.signed:
            return HomePage();
          case AuthState.unsigned:
            return LoginPage();
          case AuthState.loading:
            return SplashLoadingWidget();
        }
      },
    );
  }
}