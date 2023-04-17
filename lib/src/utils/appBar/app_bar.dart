import 'package:flutter/material.dart';
import 'package:music_app/src/router/router_path.dart';
import 'package:music_app/src/screens/Welcome/welcome_screen.dart';
import 'package:music_app/src/services/Users.dart';
import 'package:music_app/src/utils/constants/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';

appBar(BuildContext context, {cat = ""}) {
  final Uri tnc = Uri.parse('https://flutter.dev');
  final Uri pp = Uri.parse('https://flutter.dev');
  TimeOfDay now = TimeOfDay.now();
  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    }
    if (hour < 14) {
      return 'Good Afternoon';
    }
    return 'Good Evening';
  }

  Future<void> tncURL() async {
    if (!await launchUrl(tnc)) {
      throw 'Could not launch $tnc';
    }
  }

  Future<void> ppURL() async {
    if (!await launchUrl(tnc)) {
      throw 'Could not launch $tnc';
    }
  }

  return AppBar(
    backgroundColor: AppColors.bgColor,
    elevation: 0,
    title: (cat != "")
        ? Text(cat,
            style: const TextStyle(
                color: AppColors.whiteColor,
                fontSize: 20,
                fontFamily: 'AppFont',
                fontWeight: FontWeight.bold))
        : Text(greeting(),
            style: const TextStyle(
                color: AppColors.whiteColor,
                fontSize: 20,
                fontFamily: 'AppFont',
                fontWeight: FontWeight.bold)),
    actions: [
      Theme(
          data: Theme.of(context).copyWith(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent),
          child: PopupMenuButton(
              icon: const Icon(
                Icons.more_vert_rounded,
                color: AppColors.whiteColor,
              ),
              color: AppColors.secondaryColor,
              itemBuilder: (context) => [
                    PopupMenuItem(
                        child: InkWell(
                      onTap: () async {
                        Navigator.of(context).pop();
                        await users().auth.signOut();
                      },
                      child: const Text(
                        "Sign Out",
                        style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'AppFont',
                            color: AppColors.whiteColor),
                      ),
                    )),
                  ]))
    ],
  );
}


    
 

// class Appbar2 extends StatefulWidget {
//   Appbar2(this.context, this.category ,this.imageurl,this.musicurl,this.showDownload,this.name);
//   late BuildContext context;
//   late String category;
//   late String imageurl;
//   late String musicurl;
//   late bool showDownload;
//   late String name;
//   @override
//   State<Appbar2> createState() => _Appbar2State();
// }

// class _Appbar2State extends State<Appbar2> {
//   bool loader = false;
//   @override
//   Widget build(BuildContext context) {
//      return 
// } 
  
// }