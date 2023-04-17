// ignore_for_file: must_be_immutable

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:music_app/main.dart';
import 'package:music_app/src/screens/home_screen.dart';
import 'package:music_app/src/screens/musicScreen.dart';
import 'package:music_app/src/services/firestore_Database.dart';
import 'package:music_app/src/utils/appBar/app_bar.dart';
import 'package:music_app/src/utils/components/songTile.dart';
import 'package:music_app/src/utils/constants/app_colors.dart';
import 'package:music_app/src/utils/constants/app_font.dart';
import 'package:shimmer/shimmer.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late var quote = [];
  late var songs = [];
  late var categotry = [];
  bool load = false;
  void quotes() async {
    setState(() {
      load = true;
    });
    quote = await FirestoreDatabase().getQuote();
    await FirestoreDatabase().getSongs().then((value) async {
      songs = value;
      await FirestoreDatabase().getvideos().then((value) {
        for (int i = 0; i < value.length; i++) {
          songs.add(value[i]);
        }
      });
    });
    categotry = await FirestoreDatabase().getCatagory();

    print(categotry[1].get("category"));
    // print(songs);
    setState(() {
      load = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    quotes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: appBar(context),
      body: (HomeScreen.isconnected == false)
          ? SafeArea(
              child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.wifi_off_sharp,
                    color: Colors.white,
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    "No Internet Available",
                    style: AppFont.semiBold_18,
                  ),
                ],
              ),
            ))
          : Padding(
              padding:
                  const EdgeInsets.only(right: 14, left: 14, bottom: 8, top: 6),
              child: ScrollConfiguration(
                behavior: CustomScrollBehavior(),
                child: RefreshIndicator(
                  onRefresh: () {
                    return Future.delayed(Duration(seconds: 2));
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: AppColors.tertiaryColor,
                        ),
                        child: (load)
                            ? SizedBox(
                                width: 200.0,
                                height: 70.0,
                                child: Shimmer.fromColors(
                                    baseColor: AppColors.tertiaryColor,
                                    highlightColor:
                                        const Color.fromARGB(255, 54, 55, 56),
                                    child: Container(
                                      width: double.infinity,
                                      height: 70,
                                      color: Colors.white,
                                    )),
                              )
                            : Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Today's Quote",
                                      style: AppFont.semiBold_18,
                                    ),
                                    const SizedBox(height: 10),
                                    (quote.isNotEmpty)
                                        ? Text(
                                            quote[0],
                                            style: AppFont.semiBold_18,
                                          )
                                        : const SizedBox(
                                            height: 0.0,
                                          ),
                                  ],
                                ),
                              ),
                      ),
                      const SizedBox(height: 40),
                      (load)
                          ? Flexible(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    shimmerCover(),
                                    shimmerCover(),
                                    shimmerCover(),
                                    shimmerCover(),
                                    shimmerCover(),
                                  ],
                                ),
                              ),
                            )
                          : Flexible(
                              child: ListView.builder(
                                itemCount: categotry.length,
                                itemBuilder: (context, index) {
                                  List caslist = [];
                                  for (int i = 0; i < categotry.length; i++) {
                                    caslist.add(casroll(
                                        categotry[i].get("category"),
                                        categotry[i].get("category"),
                                        height));
                                  }
                                  return caslist[index];
                                },
                              ),
                            )
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Padding shimmerCover() {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: double.infinity,
          height: 100,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              shimmer(),
              shimmer(),
              shimmer(),
              shimmer(),
            ],
          ),
        ));
  }

  casroll(String title, String query, hegt) {
    return SizedBox(
      width: double.infinity,
      child: Column(children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              margin: const EdgeInsetsDirectional.only(end: 5.0),
              child: Text(
                title,
                style: AppFont.semiBold_18,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => MyMusic(query))));
              },
              child: const Text(
                "see all",
                style: AppFont.medium_16_blue,
              ),
            ),
          ],
        ),
        SizedBox(
          height: hegt / 4,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 1,
            itemBuilder: (context, index) {
              List<Widget> tiles = [];
              int count = 0;
              // print(songs);
              for (int i = 0; i < songs.length; i++) {
                if (songs[i]["category"] == query) {
                  // print(songs[i].get("name"));
                  count++;
                  if (songs[i]["isVideo"] == true) {
                    tiles.add(videoTile(
                        songs[i]["name"],
                        songs[i]["image"],
                        songs[i]["category"],
                        songs[i]["url"]));
                  } else {
                    tiles.add(songTiles(
                        songs[i]["name"],
                        songs[i]["image"],
                        songs[i]["category"],
                        songs[i]["url"]));
                  }
                }
              }
              return Row(
                children: tiles,
              );
            },
          ),
        )
      ]),
    );
  }

  shimmer() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 100,
        width: 100,
        child: Shimmer.fromColors(
          baseColor: AppColors.tertiaryColor,
          highlightColor: Color.fromARGB(255, 54, 55, 56),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
              width: 70,
              height: 70,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
