import 'package:flutter/material.dart';
import 'package:music_app/src/screens/VideoPlayer.dart';
import 'package:music_app/src/screens/player.dart';
import 'package:music_app/src/utils/constants/imgesAndPaths.dart';

class songTiles extends StatelessWidget {
  songTiles(this.name, this.image, this.category,this.songurl);
  late String name;
  late String image;
  late String category;
  late String songurl;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:(){
        // notification().send(category, name);
         Navigator.push(context,MaterialPageRoute(builder: ((context) => Player(name , image,category,songurl,false))));
      } ,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        
        child: Column(
          
          crossAxisAlignment: CrossAxisAlignment.start,
          children:  [
            SizedBox(
            
              height: 120.0,
              width: 120.0,
              child: ClipRRect(borderRadius: BorderRadius.circular(10),
                child:(image!="")? Image(
                  fit: BoxFit.cover,
                  
                  image: NetworkImage(image),): Image(
                  fit: BoxFit.cover,
    
                  image: NetworkImage(OtherConstants.defaultImage),),
              ),
              ),
            
            
            const SizedBox(height: 15.0,width: 15.0,),
            (name.length>10)?
            Text("${name.characters.take(9)}...", style: const TextStyle(color: Colors.white),):
            Text(name, style: const TextStyle(color: Colors.white),)
          ],
        ),
      ),
    );
  }
}
class videoTile extends StatelessWidget {
  videoTile(this.name, this.image, this.category,this.songurl);
  late String name;
  late String image;
  late String category;
  late String songurl;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:(){
        // notification().send(category, name);
         Navigator.push(context,MaterialPageRoute(builder: ((context) => VideoApp(url: songurl,category: category,name: name,))));
      } ,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        
        child: Stack(
          children: [
            Container(
              alignment: Alignment.center,
              child: const Icon(Icons.play_arrow_rounded,size: 22,color: Colors.white,),
            ),
            Column(
            
            crossAxisAlignment: CrossAxisAlignment.start,
            children:  [
              SizedBox(
              
                height: 120.0,
                width: 120.0,
                child: ClipRRect(borderRadius: BorderRadius.circular(10),
                  child:(image!="")? Image(
                    fit: BoxFit.cover,
                    
                    image: NetworkImage(image),): Image(
                    fit: BoxFit.cover,
            
                    image: NetworkImage(OtherConstants.defaultImage),),
                ),
                ),
              
              
              const SizedBox(height: 15.0,width: 15.0,),
              (name.length>10)?
              Text("${name.characters.take(9)}...", style: const TextStyle(color: Colors.white),):
              Text(name, style: const TextStyle(color: Colors.white),)
            ],
          )],
        ),
      ),
    );
  }
}