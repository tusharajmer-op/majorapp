import 'dart:io';

import "package:flutter/material.dart";
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:music_app/src/screens/download_screen.dart';
import 'package:music_app/src/services/MusicPlayer.dart';
import 'package:music_app/src/services/downloadsCheck.dart';
import 'package:music_app/src/utils/appBar/app_bar.dart';
import 'package:music_app/src/utils/constants/app_colors.dart';
import 'package:music_app/src/utils/constants/imgesAndPaths.dart';

import '../services/DownloadFiles.dart';
import '../utils/constants/app_font.dart';

class Player extends StatefulWidget {
  final String name;
  final String image;
  final String category;
  final String songUrl;
  final bool download;
  static  late Function ref;
  Player(this.name, this.image, this.category, this.songUrl,this.download);
  

  @override
  State<Player> createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  MusicPlayer mp = MusicPlayer();
  Duration duration = const Duration(milliseconds: 000);
  Duration progress = const Duration(milliseconds: 000);
  Duration currentposition = const Duration(milliseconds: 000);
  bool play = true;
  

  void getprogress() {
    mp.player.currentPosition.listen((event) {
      progress = event;
      setState(() {});
    });
  }
  void refresh (){
    checkexistance();
  }
  playMusic() async {
    await mp.playmusic(widget.songUrl, widget.name, widget.image);
    mp.player.current.listen((event) {
      duration = event!.audio.duration;
      setState(() {});
    });
    mp.player.isPlaying.listen(
      (event) {
        play = event;
        setState(() {});
      },
    );
  }

  @override
  void initState() {
    Player.ref =refresh;
    checkexistance();
    playMusic();
    
    getprogress();
   


    // TODO: implement initState
    super.initState();
  }
  
  @override
  void deactivate() {
    // TODO: implement deactivate
    mp.player.stop();
    super.deactivate();
  }
  bool downloaded=true;
  void checkexistance()async{
    downloaded = await checkMusic(widget.name).musiccheck(widget.name);
    print("the value is $downloaded");
    setState(() {
      
    });
  }
  bool loader = false;
  @override
  Widget build(BuildContext context) {
    String defaultImage =
        OtherConstants.defaultImage;
    return Scaffold(
      appBar:AppBar(
       backgroundColor: AppColors.bgColor,
       elevation: 0,
       title: Container(
      
      child: Text(widget.category,
          style: const TextStyle(
              color: AppColors.whiteColor,
              fontSize: 20,
              fontFamily: 'AppFont',
              fontWeight: FontWeight.bold)),
       ),
       actions: [
      (downloaded==true)? const Padding(
        padding:  EdgeInsets.all(12.0),
        child:  Icon(Icons.download_done_rounded),
      ): Padding(
        padding: const EdgeInsets.all(12.0),
        child: 
        (loader==true)?const CircularProgressIndicator(color: AppColors.tertiaryColor,):
        IconButton(onPressed: ()async{
          setState(() {
            loader=true;
          });
          await DownloadFile().download(widget.image, widget.songUrl, widget.name);
          ChatPage.f1();
          Player.ref();
          setState(() {
            loader=false;
          });
        }, icon: const Icon(Icons.download_rounded)),
      )
       ],
     ),
        
      
      // (downloaded==false)? Appbar2(context, widget.category,widget.image,widget.songUrl,false,widget.name) :Appbar2(context, widget.category,widget.image,widget.songUrl,true,widget.name),
      backgroundColor: AppColors.bgColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: 400,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: SizedBox(
                      height: 200,
                      width: 200,
                      child: (widget.image == "")
                          ? Image(
                              fit: BoxFit.cover,
                              image: NetworkImage(defaultImage))
                          : (widget.download == true)
                              ? Image.file(
                                File(
                                    "/storage/emulated/0/mediapp/images/${widget.name}.jpg"),
                                fit: BoxFit.cover,
                              )
                              : Image(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(widget.image)),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    widget.name,
                    style: AppFont.semiBold_18,
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 130),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 38.0),
                        child: ProgressBar(
                          onSeek: (value) {
                            currentposition = value;
                            mp.player.seek(currentposition);
                          },
                          timeLabelTextStyle: AppFont.semiBold_18,
                          baseBarColor: AppColors.tertiaryColor,
                          progressBarColor: AppColors.whiteColor,
                          thumbColor: AppColors.whiteColor,
                          progress: progress,
                          timeLabelLocation: TimeLabelLocation.sides,
                          total: duration,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Container(
                        width: 70,
                        height: 70,
                        color: Colors.grey[700],
                        child: GestureDetector(
                            onTap: () {
                              play = !play;
                              if (play == true) {
                                mp.player.play();
                              } else {
                                mp.player.pause();
                              }

                              setState(() {});
                            },
                            child: (play)
                                ? const Icon(
                                    Icons.pause_rounded,
                                    color: AppColors.bgColor,
                                    size: 45,
                                  )
                                : const Icon(
                                    Icons.play_arrow_rounded,
                                    color: AppColors.bgColor,
                                    size: 45,
                                  )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
