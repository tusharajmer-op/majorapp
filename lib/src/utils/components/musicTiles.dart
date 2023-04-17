import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:music_app/src/screens/VideoPlayer.dart';
import 'package:music_app/src/screens/download_screen.dart';
import 'package:music_app/src/screens/player.dart';
import 'package:music_app/src/services/DownloadFiles.dart';
import 'package:music_app/src/services/downloadsCheck.dart';
import 'package:music_app/src/utils/constants/imgesAndPaths.dart';

import '../constants/app_colors.dart';
import '../constants/app_font.dart';

class MusicTiles extends StatefulWidget {
  MusicTiles(this.name, this.image, this.category, this.url, {showDownload});
  late String image;
  late final String name;
  late final String category;
  late final url;
  bool showDownload = false;
  final defaultImage = OtherConstants.defaultImage;

  @override
  State<MusicTiles> createState() => _MusicTilesState();
}

class _MusicTilesState extends State<MusicTiles> {
  bool loader = false;

  bool downloaded = false;
  void _checkMusic() async {
    downloaded = await checkMusic(widget.name).CheckMusic(widget.name);
    setState(() {
      widget.showDownload = false;
    });
  }

  @override
  void initState() {
    _checkMusic();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: ((context) => Player(widget.name, widget.image,
                    widget.category, widget.url, false))));
      },
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(
            color: AppColors.secondaryColor,
            width: double.infinity,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  (widget.image == "")
                      ? SizedBox(
                          width: 85.0,
                          height: 85.0,
                          child: Image(
                              fit: BoxFit.cover,
                              image: NetworkImage(widget.defaultImage)))
                      : SizedBox(
                          width: 85.0,
                          height: 85.0,
                          child: (widget.showDownload == true)
                              ? Image.file(File(widget.image))
                              : Image(image: NetworkImage(widget.image))),
                  Flexible(
                    child: Container(
                        width: 90,
                        margin: const EdgeInsets.only(right: 100.0),
                        child: Text(
                          widget.name,
                          style: AppFont.semiBold_18,
                          textAlign: TextAlign.left,
                        )),
                  ),
                  (widget.showDownload == true)
                      ? const SizedBox(
                          height: 0.0,
                        )
                      : GestureDetector(
                          onTap: () async {
                            loader = true;

                            setState(() {});

                            downloaded = (widget.image == "")
                                ? await DownloadFile().download(
                                    widget.defaultImage,
                                    widget.url,
                                    widget.name)
                                : await DownloadFile().download(
                                    widget.image, widget.url, widget.name);
                            if (downloaded == true) {
                              ChatPage.f1();
                              checkMusic(widget.name).updateDownloads();
                            }
                            setState(() {
                              loader = false;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 18),
                            child: Padding(
                              padding: EdgeInsets.all(3.0),
                              child: (loader == true)
                                  ? const CircularProgressIndicator(
                                      color: AppColors.tertiaryColor,
                                    )
                                  : (downloaded == false)
                                      ? const Icon(
                                          Icons.download_rounded,
                                          color: AppColors.tertiaryColor,
                                          size: 22.0,
                                        )
                                      : const Icon(
                                          Icons.download_done_rounded,
                                          color: AppColors.tertiaryColor,
                                          size: 22.0,
                                        ),
                            ),
                          ),
                        )
                ]),
          ),
        ),
      ),
    );
  }
}

class VideoTiles extends StatefulWidget {
  VideoTiles(this.name, this.image, this.category, this.url, {showDownload});
  late String image;
  late final String name;
  late final String category;
  late final url;
  bool showDownload = false;
  final defaultImage = OtherConstants.defaultImage;

  @override
  State<VideoTiles> createState() => _VideoTilesState();
}

class _VideoTilesState extends State<VideoTiles> {
  bool loader = false;

  bool downloaded = false;
  void _checkMusic() async {
    downloaded = await checkMusic(widget.name).CheckMusic(widget.name);
    setState(() {
      widget.showDownload = false;
    });
  }

  @override
  void initState() {
    _checkMusic();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: ((context) => VideoApp(url: widget.url,name: widget.name,category: widget.category,))));
      },
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(
            color: AppColors.secondaryColor,
            height: 85,
            width: double.infinity,
            child: Stack(
              children: [
                
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      (widget.image == "")
                          ? SizedBox(
                              width: 85.0,
                              height: 85.0,
                              child: Image(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(widget.defaultImage)))
                          : SizedBox(
                              width: 85.0,
                              height: 85.0,
                              child: (widget.showDownload == true)
                                  ? Image.file(File(widget.image))
                                  : Image(image: NetworkImage(widget.image))),
                      Flexible(
                        child: Container(
                            width: 90,
                            margin: const EdgeInsets.only(right: 100.0),
                            child: Text(
                              widget.name,
                              style: AppFont.semiBold_18,
                              textAlign: TextAlign.left,
                            )),
                      ),
                      const SizedBox(width: 40,)
                    ]),
                    Container(
                  alignment: Alignment.bottomLeft,
                  child: const Icon(Icons.play_arrow,color: Colors.white,size: 22,),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
