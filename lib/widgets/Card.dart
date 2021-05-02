import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:html_widgets/html_widgets.dart';
import 'package:netflix/models/list.dart';
import 'package:netflix/screens/SingleMovie.dart';


class Thumbnail extends StatelessWidget {

  final String imgSrc;
  final String name;
  final String description;
  final bool isLoading;
  final  data;

  Thumbnail(
    this.imgSrc,
    this.name,
    this.description,
    this.isLoading,
    this.data,
  );

   _addToList(movie, context){
   final box = Hive.box('netflix-clone');
       box.add(MYList(
            id: movie.id,
            title: movie.title,
            imageURL: "https://image.tmdb.org/t/p/original${movie.backdropPath}",
            ismovie: true,
            overview: movie.overview,
            popularity: movie.popularity,
      )); 
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("${movie.title} added to List",
        style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.black,
      ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          HtmlImage(
            src: imgSrc,
            width: MediaQuery.of(context).size.width * 1.0,
            height: 300,
           ),
           Row(
             children : [
            Container(
              width:MediaQuery.of(context).size.width * 0.5,
              child: H1(
               text: name,
               margin: 10,
               fontWeight: 900,  
               isLoading: isLoading,
               textAlign: "left",
           ),
            ),
             Column(
                children:[
                IconButton(
                 icon: Icon(Icons.notifications), 
                 onPressed: (){}
                ),
                Text("Remind Me  ")
                ]
              ),
              Container(width: 30,),
              Column(
                children:[
                IconButton(
                 icon: Icon(Icons.add), 
                 onPressed: (){
                   _addToList(data, context);
                 }
                ),
                Text("My List")
                ]
              ),
             ]
           ),
           H4(
             text: "Watch Now",
             margin: 10,
             isLoading: isLoading,
             onClick: (){
               Navigator.push(context, MaterialPageRoute(builder: (context) => SingleMovie(data)));
             },
            ),
           P(
             text: name,
             margin: 10,
             isLoading: isLoading, 
            ),
            P(
              text: description,
              margin: 10,
              isLoading: isLoading,
            ),

        ]
      ),
    );
  }
}