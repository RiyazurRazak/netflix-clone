import 'package:flutter/material.dart';
import 'package:html_widgets/html_widgets.dart';
import 'package:netflix/main.dart';

import 'package:netflix/services/getTvShows.dart';
import 'package:netflix/widgets/RowBuilder.dart';


class TVShows extends StatefulWidget {
  @override
  _TVShowsState createState() => _TVShowsState();
}

class _TVShowsState extends State<TVShows> {

  Future _latest;
  Future _popular;
  Future _topRated;
  Future _action;
  Future _animation;
  Future _comedy;
  Future _crime;
  Future _soap;
  Future _science;
  Future _documentry;
  Future _western;
  Future _mystery;
  Future _talk;

  @override
  void initState(){
    super.initState();
    _latest = GetTvShows().getShows('https://api.themoviedb.org/3/tv/airing_today?api_key=<<your api key>>');
    _popular = GetTvShows().getShows('https://api.themoviedb.org/3/tv/popular?api_key=<<your api key>>');
    _topRated = GetTvShows().getShows('https://api.themoviedb.org/3/tv/top_rated?api_key=<<your api key>>');
    _action = GetTvShows().getShows('https://api.themoviedb.org/3/discover/tv?api_key=<<your api key>>&with_genres=10759');
    _animation = GetTvShows().getShows('https://api.themoviedb.org/3/discover/tv?api_key=<<your api key>>&with_genres=16');
    _comedy = GetTvShows().getShows('https://api.themoviedb.org/3/discover/tv?api_key=<<your api key>>&with_genres=35');
    _crime = GetTvShows().getShows('https://api.themoviedb.org/3/discover/tv?api_key=<<your api key>>&with_genres=80');
    _soap = GetTvShows().getShows('https://api.themoviedb.org/3/discover/tv?api_key=<<your api key>>&with_genres=10766');
    _science = GetTvShows().getShows('https://api.themoviedb.org/3/discover/tv?api_key=<<your api key>>&with_genres=10765');
    _documentry = GetTvShows().getShows('https://api.themoviedb.org/3/discover/tv?api_key=<<your api key>>&with_genres=99');
    _western = GetTvShows().getShows('https://api.themoviedb.org/3/discover/tv?api_key=<<your api key>>&with_genres=37');
    _mystery = GetTvShows().getShows('https://api.themoviedb.org/3/discover/tv?api_key=<<your api key>>&with_genres=9648');
    _talk = GetTvShows().getShows('https://api.themoviedb.org/3/discover/tv?api_key=<<your api key>>&with_genres=10767');
  }

    Future<bool> _backHandller()async{
      Navigator.pushReplacement(context,  MaterialPageRoute(builder: (context) => MyHomePage()));
      return true;
  }


  @override
  Widget build(BuildContext context) {
     return WillPopScope(
          onWillPop: _backHandller ,
          child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children:[
            RowBuilder("Latest", _latest),
            RowBuilder("Most Popular", _popular),
            RowBuilder("Top Rated", _topRated),
            RowBuilder("Action & Adventure", _action),   
            RowBuilder("Comedy", _comedy), 
            RowBuilder("Animation", _animation),
            RowBuilder("Soap", _soap), 
            RowBuilder("Crime", _crime),
            RowBuilder("Sci-Fi & Fantasy", _science),
            RowBuilder("Documentry", _documentry),
            RowBuilder("Western", _western),
            RowBuilder("Mystery", _mystery),
            RowBuilder("Talk Show", _talk),
            H5(
              text: "Developed By Riyazur Razak",
              margin: 20,
              textAlign: "center",
            )
          ]
        ),)
    );
  }
}