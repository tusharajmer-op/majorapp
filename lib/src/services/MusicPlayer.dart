

import 'dart:io';
import 'dart:typed_data';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:music_app/src/utils/constants/imgesAndPaths.dart';
// code for music player goes here

class MusicPlayer{
final player = AssetsAudioPlayer();


playmusic (String songUrl,String name,String image) async{
  if(songUrl.contains("/mediapp")==false){
  try{
  await player.open(Audio.network(songUrl,metas:Metas(title: name,album: name , image: MetasImage.network(image))),showNotification: true,notificationSettings: const NotificationSettings(nextEnabled: false,prevEnabled: false));
  
  }
  catch(e){
    throw e;
  }
  
  }
  else{
  
    try{
    
    await player.open(Audio.file('${OtherConstants.defaultPath}/music/$name.mp3',metas:Metas(title: name,album: name , image: MetasImage.file('${OtherConstants.defaultPath}/images/$name.jpg'))),showNotification: true,notificationSettings: const NotificationSettings(nextEnabled: false,prevEnabled: false));
   
    }
    catch(e){
     
      throw e;
    }
  }





}}