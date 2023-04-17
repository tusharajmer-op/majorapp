import "package:flutter/material.dart";
import 'package:music_app/src/services/firestore_Database.dart';
import 'package:music_app/src/utils/appBar/app_bar.dart';
import 'package:music_app/src/utils/components/musicTiles.dart';
import 'package:music_app/src/utils/constants/app_colors.dart';

class MyMusic extends StatefulWidget {
  late final String music;
  MyMusic(this.music);

  @override
  State<MyMusic> createState() => _MyMusicState();
}

class _MyMusicState extends State<MyMusic> {
  List musics = [];
  void getmusic(param0) async {
    await FirestoreDatabase().getmusic(param0).then((values) async {
      musics = values;
      await FirestoreDatabase().getvideosquery(param0).then((value) {
        for (int i = 0; i < value.length; i++) {
          musics.add(value[i]);
        }
      });
    });
    setState(() {});
  }

  @override
  void initState() {
    getmusic(widget.music);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: appBar(context, cat: widget.music),
      body: (musics.isEmpty)
          ? const SizedBox(
              height: 0.0,
            )
          : SafeArea(
              child: SizedBox(
              // height: double.infinity,

              child: ListView.builder(
                itemCount: 1,
                itemBuilder: (context, index) {
                  List<Widget> Widgets1 = [];
                  for (var element in musics) {
                    if (element["isVideo"] == false) {
                      Widgets1.add(MusicTiles(element["name"], element["image"],
                          element["category"], element["url"]));
                    }
                    else{
                      Widgets1.add(VideoTiles(element["name"], element["image"],
                          element["category"], element["url"],showDownload: false,));
                    }
                  }
                  return Column(
                    children: Widgets1,
                  );
                },
              ),
            )),
    );
  }
}
