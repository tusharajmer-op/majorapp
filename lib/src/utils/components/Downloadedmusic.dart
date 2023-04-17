import 'dart:io';
import 'dart:typed_data';
import "package:flutter/material.dart";
import 'package:music_app/src/screens/player.dart';
import 'package:music_app/src/utils/components/alertDialogBox.dart';

import '../constants/app_colors.dart';
import '../constants/app_font.dart';

class Downloadtiles extends StatefulWidget {
  Downloadtiles(this.name, this.image , this.song, this.refresh);
  late final name;
  late final image;
  late final song;
  Function refresh;
  


  @override
  State<Downloadtiles> createState() => _DownloadtilesState();
}

class _DownloadtilesState extends State<Downloadtiles> {
  String imagepath ="";
  Uint8List img = Uint8List(0);
  // Uri temImage  =  Uri.parse(widget.image);
  convertuint()async{
    imagepath  = widget.image.toString();
  
    // Uri temImage = Uri.parse(widget.image);
    // File? imageFile = new File.fromUri(temImage);
    //  await imageFile.readAsBytes().then((value){
    //     img = Uint8List.fromList(value);
    // });
   


    setState(() {
    
    });
  }
  @override
  void initState() {
    convertuint();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    print(widget.image.toString());
    return GestureDetector(
      onTap: (){
        Navigator.push(context,MaterialPageRoute(builder: ((context) => Player(widget.name,widget.image,widget.name,widget.song,true))));
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
              
                  
                  SizedBox(
                    width: 85.0,
                    height: 85.0,
                  
                    child:(img==Uint8List(0))? const SizedBox(height: 0.0,) :Image.file(File("/storage/emulated/0/mediapp/images/${widget.name}.jpg"))),
                  Flexible(
                    
                    child: Container(
                      
                      width: 90,
                      margin:const EdgeInsets.only(right: 100.0),
                      child: Text(widget.name,style: AppFont.semiBold_18, textAlign: TextAlign.left,)),
                  ),

                   IconButton(
                    onPressed: ()async{
                        await alertbox(widget.name,context).showalertbox(context);
                        setState(() {
                          
                        });
                          
                        
                    },
                    icon: const Icon(Icons.delete_rounded),iconSize: 22.0),
                  
            ]),
          ),
        ),
      ),
    );
  }
}