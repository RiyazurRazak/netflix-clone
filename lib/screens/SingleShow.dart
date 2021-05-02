import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:html_widgets/html_widgets.dart';
import 'package:netflix/models/list.dart';
import 'package:netflix/services/getMovies.dart';
import 'package:netflix/services/getVideo.dart';
import 'package:netflix/widgets/RowBuilder.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class SingleShow extends StatefulWidget {

final data;

SingleShow(
  this.data
);

  @override
  _SingleShowState createState() => _SingleShowState(data);
}

class _SingleShowState extends State<SingleShow> {


    final showData;
    Future _video;
    Future _recomended;
    Future _similar;

    _SingleShowState(this.showData);

   @override
    void initState() { 
      super.initState();
      _video = GetVideo().getVideo('https://api.themoviedb.org/3/tv/${showData.id}/videos?api_key=<<your api key>>');
      _recomended = GetMovies().getMovies('https://api.themoviedb.org/3/tv/${showData.id}/recommendations?api_key=<<your api key>>');
      _similar = GetMovies().getMovies('https://api.themoviedb.org/3/tv/${showData.id}/similar?api_key=<<your api key>>');
    }

     _addToList(show,context){
      final box = Hive.box('netflix-clone');
       box.add(MYList(
            id: show.id,
            title: show.name,
            imageURL: "https://image.tmdb.org/t/p/original${show.backdropPath}",
            ismovie: false,
            overview: show.overview,
            popularity: show.popularity,
      ));
       Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("${show.name} added to List",
        style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.black,
      )); 
    }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body:SafeArea(
      child:ListView(
      children: [
        FutureBuilder(
          future: _video,
          builder: (context, snapshot){
            if(snapshot.hasData){
              return YoutubePlayer(
                controller: YoutubePlayerController(
                  initialVideoId:snapshot.data.results.length > 0 ? snapshot.data.results[0].key : '',
                  flags: YoutubePlayerFlags(
                    enableCaption: false,
                    controlsVisibleAtStart: true,
                    autoPlay: true,
                    mute: false,
                  )
                  ),
              );
            }else{
              return Container(
                height: 300,
                color: Colors.black54,
                );
            }
          }),
           Row(
            children: [
             Container(
               width: MediaQuery.of(context).size.width * 0.6,
               child: H1(
               text: showData.name,
               margin: 20,
             ),
             ),
              Container(
               width: MediaQuery.of(context).size.width * 0.4,
               child: Column(
                children:[
                IconButton(
                 icon: Icon(Icons.add), 
                 onPressed: (){
                   _addToList(showData, context);
                 }
                ),
                Text("My List")
                ],),
              ),
            ],
          ),
         
          P(
            text: showData.overview,
            margin: 20,
          ),
          H3(
            text:"Popularity : ${showData.popularity > 2000 ? "High" : "Low"}",
            margin: 20,
          ),
          H3(
            text: "ScreenShots",
            margin: 20,
          ),
          HtmlImage(
            src: 'https://image.tmdb.org/t/p/w500${showData.backdropPath}',
            width: MediaQuery.of(context).size.width * 1.0,
            height: 300,
          ),
          RowBuilder("Recomended Shows", _recomended),
          RowBuilder("Similar Shows", _similar),

         
      ],
      ) 
    ),
    );
    
  }
}