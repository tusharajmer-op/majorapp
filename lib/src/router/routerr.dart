

import 'package:flutter/material.dart';
import 'package:music_app/src/router/router_path.dart';
import 'package:music_app/src/screens/forgot_password_screen.dart';
import 'package:music_app/src/screens/home_screen.dart';
import 'package:music_app/src/screens/login_screen.dart';
import 'package:music_app/src/screens/musicScreen.dart';
import 'package:music_app/src/screens/register_screen.dart';
import 'package:music_app/src/screens/splash_screen.dart';
import 'package:page_transition/page_transition.dart';

import '../screens/Welcome/welcome_screen.dart';

class Routerr {
  static RouteFactory onGenerateRouter = (RouteSettings settings) {
    switch (settings.name) {
      case splashScreen:
        return _generateMaterialRoute(const SplashScreen());
      case loginScreen:
        return _generateMaterialRoute(const LoginScreen());
      case forgotPasswordScreen:
        return _generateMaterialRoute(const ForgotPasswordScreen());
      case registerScreen:
        return _generateMaterialRoute(const RegisterScreen());
      case homeScreen:
        return _generateMaterialRoute( HomeScreen());
      case welcome:
        return _generateMaterialRoute( const WelcomeScreen());
      case music:{
        final music = settings.arguments;
        return MaterialPageRoute(builder: (context)=>MyMusic(""));
    }
  
  }};}

PageTransition _generateMaterialRoute(Widget screen) {
  return PageTransition(
      child: screen,
      type: PageTransitionType.rightToLeft,
      duration: const Duration(milliseconds: 600));
}
