import 'package:flutter/material.dart';
import 'package:netflix/services/getMovies.dart';
import 'package:netflix/widgets/Card.dart';

class Upcomming extends StatefulWidget {
  @override
  _UpcommingState createState() => _UpcommingState();
}

class _UpcommingState extends State<Upcomming> {

  Future _upcommingMovies;


  @override
  void initState() { 
    super.initState();
    _upcommingMovies = GetMovies().getMovies('https://api.themoviedb.org/3/movie/upcoming?api_key=<<your api key>>&page=2');
  }
  @override
  Widget build(BuildContext context) {
    return (SafeArea(
     child: FutureBuilder(
        future: _upcommingMovies,
        builder: (context, snapshot){
          if(snapshot.hasData){
            return(
              ListView.builder(
                itemCount: snapshot.data.results.length,
                itemBuilder: (context, index){
                  final movie = snapshot.data.results[index];
                  return Thumbnail('https://image.tmdb.org/t/p/w500${movie.backdropPath}', movie.originalTitle, movie.overview, false, movie);
                })
            );
          }else{
            return Container();
          }
        },
      )

    ));
  }
}