

import 'package:flutter/material.dart';
import 'package:music_app/src/screens/download_screen.dart';
import 'package:music_app/src/utils/constants/app_colors.dart';
import 'package:music_app/src/utils/constants/app_font.dart';

import '../../services/DownloadFiles.dart';
import '../../services/downloadsCheck.dart';

class alertbox{
  alertbox(this.name,this.context);
  late String name;
  late BuildContext context;
  showalertbox(context){
    return showDialog(context: context, builder:(context) {
      return AlertDialog(
        title:  const Text("Are you sure?",style: AppFont.semiBold_18,),
        backgroundColor: AppColors.tertiaryColor,
        actions: [
          TextButton(onPressed: ()async{
            await DownloadFile().delete(name);
            ChatPage.f1();
            await checkMusic(name).DeleteMusic(name);
            Navigator.pop(context);
          }, child: const Text("yes",style: AppFont.semiBold_18 ,)),
          TextButton(onPressed: (){
            Navigator.pop(context);
          }, child: const Text("cancel",style: AppFont.semiBold_18))
        ],
      );
    },);
  }
}

 