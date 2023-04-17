import 'dart:io';

import 'package:flutter/material.dart';
import 'package:music_app/src/services/ShowDownloaded.dart';
import 'package:music_app/src/utils/appBar/app_bar.dart';
import 'package:music_app/src/utils/components/Downloadedmusic.dart';
import 'package:music_app/src/utils/constants/app_colors.dart';

import '../utils/constants/app_font.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);
  static late Function f1;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
    
    List data=[[],[]];
    
  showfile()async{
    data = await showfiles().showFiles();
    print("object");
    print(data);
    setState(() {

    });
    
    
  }
  // void update()async{
    
  // }
  @override
  void initState() {
    // update();
    showfile();
    ChatPage.f1= refresh;
    super.initState();
  }
  refresh()async{
    data = await showfiles().showFiles();
    setState(() {
      
    });
    return true;
  }
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: appBar(context),
      backgroundColor: AppColors.bgColor,
      body: RefreshIndicator(
        onRefresh: (){return  refresh();},
        child: (data[1].isEmpty)
            ? const SafeArea(
                child: Center(
                child: Text(
                  "No music is downloaded yet",
                  style: AppFont.semiBold_18,
                ),
              ))
            : SafeArea(child: SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: ListView.builder(
                itemCount: 1,
                itemBuilder:(context, index) {
                  List<Widget> tiles=[];
                  for(int i=0;i<data[0].length; i++){
                    String temp = data[0][i].toString().split("images/")[1].toString().split(".jpg")[0].toString();
                    print(temp);
                    String music="";
                    print(data[1][i]);
                    for(int j=0;j<data[1].length;j++){
                    if(data[1][j].toString().contains(temp)==true){
                             music = data[1][j].toString();
      
                             tiles.add(Downloadtiles(temp.replaceAll("'", ""), temp = data[0][i].toString(), music,refresh));
                             }
                      
                  }}
                  print(tiles.length);
                  return Column(children:tiles);
                },
            )),
          ),
      ));
  }
}
