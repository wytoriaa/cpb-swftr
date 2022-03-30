import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:capybaflutter/controller/user-c.dart';

import 'home-page.dart';
class Splash extends StatefulWidget {

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserInfo>(
      builder: (context, userControll, child){
        switch (userControll.authState){
          case AuthState.signed:
            return HomePage();
          case AuthState.unsigned:
            return LoginPage();
          case AuthState.loading:
            return SplashLoadingWidget()
        }
      });
  }
}