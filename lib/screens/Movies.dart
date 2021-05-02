import 'package:flutter/material.dart';
import 'package:html_widgets/html_widgets.dart';
import 'package:netflix/main.dart';
import 'package:netflix/services/getMovies.dart';
import 'package:netflix/widgets/RowBuilder.dart';

class MoviesPage extends StatefulWidget {
  @override
  _MoviesState createState() => _MoviesState();
}

class _MoviesState extends State<MoviesPage>{

  Future _action;
  Future _adventure;
  Future _animation;
  Future _comedy;
  Future _crime;
  Future _science;
  Future _documentry;
  Future _western;
  Future _romance;
  Future _music;
  Future _thriller;
  Future _drama;
  Future _fantasy;
  Future _horror;


  @override
  void initState(){
    super.initState();
    _action = GetMovies().getMovies('https://api.themoviedb.org/3/discover/movie?api_key=<<your api key>>&with_genres=28');
    _adventure = GetMovies().getMovies('https://api.themoviedb.org/3/discover/movie?api_key=<<your api key>>&with_genres=12');
     _horror = GetMovies().getMovies('https://api.themoviedb.org/3/discover/movie?api_key=<<your api key>>&with_genres=27');
    _animation = GetMovies().getMovies('https://api.themoviedb.org/3/discover/movie?api_key=<<your api key>>&with_genres=16');
    _comedy = GetMovies().getMovies('https://api.themoviedb.org/3/discover/movie?api_key=<<your api key>>&with_genres=35');
    _crime = GetMovies().getMovies('https://api.themoviedb.org/3/discover/movie?api_key=<<your api key>>&with_genres=80');
    _science = GetMovies().getMovies('https://api.themoviedb.org/3/discover/movie?api_key=<<your api key>>&with_genres=878');
    _documentry = GetMovies().getMovies('https://api.themoviedb.org/3/discover/movie?api_key=<<your api key>>&with_genres=99');
    _western = GetMovies().getMovies('https://api.themoviedb.org/3/discover/movie?api_key=<<your api key>>&with_genres=37');
    _romance = GetMovies().getMovies('https://api.themoviedb.org/3/discover/movie?api_key=<<your api key>>&with_genres=10749');
    _music = GetMovies().getMovies('https://api.themoviedb.org/3/discover/movie?api_key=<<your api key>>&with_genres=10402');
    _thriller = GetMovies().getMovies('https://api.themoviedb.org/3/discover/movie?api_key=<<your api key>>&with_genres=53');
    _drama = GetMovies().getMovies('https://api.themoviedb.org/3/discover/movie?api_key=<<your api key>>&with_genres=18');
    _fantasy = GetMovies().getMovies('https://api.themoviedb.org/3/discover/movie?api_key=<<your api key>>&with_genres=14');
  }

  Future<bool> _backHandller()async{
      Navigator.pushReplacement(context,  MaterialPageRoute(builder: (context) => MyHomePage()));
      return true;
  }

  @override
  Widget build(BuildContext context) {
    
     return WillPopScope(
          onWillPop: _backHandller ,
          child: 
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
            children:[
            RowBuilder("Action", _action),
            RowBuilder("Horror", _horror),
            RowBuilder("Romance", _romance),
            RowBuilder("Science Fiction", _science),
            RowBuilder("Animation", _animation),
            RowBuilder("Comedy", _comedy),
            RowBuilder("Crime", _crime),
            RowBuilder("Adventure", _adventure),
            RowBuilder("Documentry", _documentry),
            RowBuilder("Music", _music),
            RowBuilder("Western", _western),
            RowBuilder("Thriller", _thriller),
            RowBuilder("Drama", _drama),
            RowBuilder("Fantasy", _fantasy),
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