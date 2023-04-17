import "package:flutter/material.dart";
import 'package:music_app/src/router/router_path.dart';
import 'package:music_app/src/screens/musicScreen.dart';

import '../constants/app_font.dart';


class CateforyTiles extends StatelessWidget {
  CateforyTiles(this.image, this.name,this.wth,this.heit);
  late String image;
  late  String name;
  late var wth;
  late var heit;
  

  @override
  Widget build(BuildContext context) {
    

    return GestureDetector(
      onTap: (){
        Navigator.push(context,MaterialPageRoute(builder: ((context) => MyMusic(name))));
      },
      child: ClipRRect(
        
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: SizedBox(
              width: wth/4,
              height:heit/12 ,
              child: Stack(
                children: [
                  Container(
                    child: Image(image: NetworkImage(image)),
                  ),
                  Container(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      name,
                      style: AppFont.semiBold_18,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
