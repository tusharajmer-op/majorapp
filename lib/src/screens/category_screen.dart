import 'dart:async';

import 'package:flutter/material.dart';
import 'package:music_app/src/services/firestore_Database.dart';
import 'package:music_app/src/utils/appBar/app_bar.dart';
import 'package:music_app/src/utils/components/categoryTile.dart';
import 'package:music_app/src/utils/constants/app_colors.dart';
import 'package:shimmer/shimmer.dart';

import '../utils/constants/app_font.dart';
import 'home_screen.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  late StreamSubscription ntwk;
  List category = [];
  getCategoryDetails() async {
    category = await FirestoreDatabase().getCatagory();
    setState(() {});
  }

  @override
  void initState() {
    getCategoryDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var ht = MediaQuery.of(context).size.height;
    var wt = MediaQuery.of(context).size.width;
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
            : SafeArea(
                child: (category.isNotEmpty)
                    ? SizedBox(
                        height: ht,
                        width: wt,
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                          ),
                          itemCount: category.length,
                          itemBuilder: (context, index) {
                            return SizedBox(
                                height: ht / 24,
                                child: CateforyTiles(
                                  category[index].get("image"),
                                  category[index].get("category"),
                                  wt,
                                  ht,
                                ));
                          },
                        ))
                    : SizedBox(
                        height: ht,
                        width: wt,
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                          ),
                          itemCount: 9,
                          itemBuilder: (context, index) {
                            List<Widget> shimers = [
                              shimmer(),
                              shimmer(),
                              shimmer(),
                              shimmer(),
                              shimmer(),
                              shimmer(),
                              shimmer(),
                              shimmer(),
                              shimmer(),
                            ];
                            return shimers[index];
                          },
                        )),
              ));
  }
}

shimmer() {
  return ClipRRect(
    borderRadius: BorderRadius.circular(12),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 300,
        width: 300,
        child: Shimmer.fromColors(
          baseColor: AppColors.tertiaryColor,
          highlightColor: Color.fromARGB(255, 54, 55, 56),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
              width: 50,
              height: 50,
              color: Colors.white,
            ),
          ),
        ),
      ),
    ),
  );
}
