import 'package:achat/views/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/firebase_auth_controller.dart';
import 'auth/sign_in_screen.dart';
import 'home_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final status = context.watch<FirebaseAuthController>().authStatus;
    switch (status) {
      case AuthStatus.authenticate:
        return HomeScreen();
      case AuthStatus.unauthenticate:
        return SignInScreen();
      default:
        return SplashScreen();
    }
  }
}
