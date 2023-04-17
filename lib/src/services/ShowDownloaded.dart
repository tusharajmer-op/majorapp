import 'dart:io' as io;

import 'package:flutter/cupertino.dart';
import 'package:music_app/src/utils/constants/imgesAndPaths.dart';
class showfiles{
  late final  path = OtherConstants.defaultPath;

  
  List imagefile =[];
   List  musicfile=[];
   _getFiles()async {
   if(await io.Directory(path+"/music").exists()){
     imagefile =io.Directory(path+"/images").listSync();
     musicfile =io.Directory(path+"/music").listSync();}
     else{
      imagefile =[];
      musicfile=[];
     }
  }

  showFiles()async{
    await _getFiles();

    return [imagefile,musicfile];
  }
  
}