import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:html_widgets/html_widgets.dart';
import 'package:netflix/models/list.dart';
import 'package:netflix/services/getMovies.dart';
import 'package:netflix/services/getVideo.dart';
import 'package:netflix/widgets/RowBuilder.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class SingleMovie extends StatefulWidget {

final data;

SingleMovie(
  this.data
);

  @override
  _SingleMovieState createState() => _SingleMovieState(data);
}

class _SingleMovieState extends State<SingleMovie> {


    final movieData;
    Future _video;
    Future _recomended;
    Future _similar;

    _SingleMovieState(this.movieData);

   @override
    void initState() { 
      super.initState();
      _video = GetVideo().getVideo('https://api.themoviedb.org/3/movie/${movieData.id}/videos?api_key=<<your api key>>');
      _recomended = GetMovies().getMovies('https://api.themoviedb.org/3/movie/${movieData.id}/recommendations?api_key=<<your api key>>');
      _similar = GetMovies().getMovies('https://api.themoviedb.org/3/movie/${movieData.id}/similar?api_key=<<your api key>>');
    }

    _addToList(movie,context){
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
                  initialVideoId: snapshot.data.results[0].key,
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
               text: movieData.title,
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
                   _addToList(movieData,context);
                 }
                ),
                Text("My List")
                ],),
              ),
            ],
          ),
         
          P(
            text: movieData.overview,
            margin: 20,
          ),
          H3(
            text:"Popularity : ${movieData.popularity > 2000 ? "High" : "Low"}",
            margin: 20,
          ),
          H3(
            text: "ScreenShots",
            margin: 20,
          ),
          HtmlImage(
            src: 'https://image.tmdb.org/t/p/w500${movieData.backdropPath}',
            width: MediaQuery.of(context).size.width * 1.0,
            height: 300,
          ),
          RowBuilder("Recomended Movies", _recomended),
          RowBuilder("Similar Movies", _similar),

         
      ],
      ) 
    ),
    );
    
  }
}