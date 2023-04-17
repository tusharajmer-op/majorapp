
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:music_app/src/utils/constants/imgesAndPaths.dart';
import 'package:permission_handler/permission_handler.dart';
// import 'package:flutter_downloader/flutter_downloader.dart';
class DownloadFile{
  Future _getpath()async{
    var tempDir = OtherConstants.defaultPath;
  
    if(await Permission.storage.status.isDenied){
      if(await Permission.storage.request().isGranted&& await Permission.accessMediaLocation.request().isGranted){
      if(await Permission.manageExternalStorage.request().isGranted){
        if(await Directory(tempDir).exists()){
          await Directory(tempDir).delete(recursive: true);
        }
       Directory dir = await Directory(tempDir).create();
       return dir.path;
      }}
    }
    return tempDir;
    
  }

  Future<bool> download(String imageurl , String musicurl, String name)async{
    final path = await _getpath();
       
    var dio = Dio();
    try{
      var response = await dio.download(imageurl,"$path/images/$name.jpg",deleteOnError: true,);
      var response1 = await dio.download(musicurl,"$path/music/$name.mp3",deleteOnError: true);
      if(response.statusCode==response1.statusCode){
        return true;
      }

      return false;
    }
    catch(e){
      return false;
    
      
    }
    
    
    


  }

  Future<bool> delete(name)async {
    final path = await _getpath();
    try{
      await Directory("$path/images/$name.jpg").delete(recursive:true);
      await Directory("$path/music/$name.mp3").delete(recursive:true);
      return true;
    }
    catch(e){
      return false;
    }
  }
}
