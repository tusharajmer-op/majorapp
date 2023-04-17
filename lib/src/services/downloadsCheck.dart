import 'dart:convert';
import 'dart:io';

import 'package:music_app/src/utils/constants/imgesAndPaths.dart';
import "package:path_provider/path_provider.dart";
class checkMusic{
 List MusicContainer = [];
  Map<String, dynamic> musictrack ={};
  checkMusic(this.music);
  final String music;
  getpath()async{
  String file = "DownloadsFiles";
    final path = File('${(await getApplicationDocumentsDirectory()).path}/$file.json');
    return path;
  }
  void updateDownloads() async {
    
    await readFile();
    try{
    final File path = await getpath();
    Map<String,dynamic> _newjson ={"music":music};
    musictrack.addAll(_newjson);
    MusicContainer.add(_newjson);
    print(MusicContainer);
    String _JsonMusicString = jsonEncode(MusicContainer);
    await path.writeAsString(_JsonMusicString);
    print("From write block");
    print(_JsonMusicString);
    }
    catch(e){

      throw e;

    }
    
  }

  readFile()async{
    final File path = await getpath();
  
    bool exist = await path.exists();
    if(exist){
      try{
        String Musicjason = await path.readAsString();
        MusicContainer = jsonDecode(Musicjason);
        print("From read block");
        print(MusicContainer);
      }
      catch(e){
        throw e;
      }
    }
  }
  Future<bool> CheckMusic(String musicName)async {

    if(MusicContainer.isEmpty){
      print("is empty");
      return false;
    }
    else{
      for(int i=0; i<MusicContainer.length;i++){
        if(MusicContainer[i]["music"]==musicName){
          print(MusicContainer[i]["music"]);
          return true;
        }
      }
    }
  return false;
  }
  Future<bool> DeleteMusic(String musicName)async {
  
    await readFile();
    if(MusicContainer.isEmpty){
      print("is empty");
      return false;
    }
    else{
      final File path = await getpath();
      for(int i=0; i<MusicContainer.length;i++){
        if(MusicContainer[i]["music"]==musicName){
          MusicContainer.removeAt(i);
          String _JsonMusicString = jsonEncode(MusicContainer);
          await path.writeAsString(_JsonMusicString);
          
          return true;
        }
      }
    }
  return false;
  }
  Future<bool> musiccheck(String name)async{
    if(await File("${OtherConstants.defaultPath}/music/$name.mp3").exists()==true){
      return true;
    }
    else{ return false; }
  }

}