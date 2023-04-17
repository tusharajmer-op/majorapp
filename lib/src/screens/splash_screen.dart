// ignore_for_file: library_private_types_in_public_api
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:music_app/src/router/router_path.dart';
import 'package:music_app/src/utils/constants/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        Timer(const Duration(seconds: 2), () {
          Navigator.pushNamed(context, welcome);
        });
      } else {
        Timer(const Duration(seconds: 2), () {
          Navigator.pushNamed(context, homeScreen);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.bgColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/images/Group_30.png',
                  height: 130, width: 130),
              const Text(
                "JSC Meditation App",
                style: TextStyle(color: AppColors.whiteColor, fontSize: 24),
              )
            ],
          ),
        ));
  }
}
