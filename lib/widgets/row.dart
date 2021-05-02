import 'package:flutter/material.dart';
import 'package:html_widgets/html_widgets.dart';
import 'package:netflix/screens/SingleMovie.dart';
import 'package:netflix/screens/SingleShow.dart';


class Rows extends StatelessWidget {

  final movies;

  Rows(
    this.movies
  );



  @override
  Widget build(BuildContext context) {
    return ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: movies.data.results.length,
              itemBuilder: (context , index){
              if(movies.data.results != null){
              final movie = movies.data.results[index];
              if(movie.posterPath != null){
              return  HtmlImage(
                          src : "https://image.tmdb.org/t/p/w200${movie.posterPath}", 
                          width: 120,
                          height: 80,
                          size: "fitHeight",
                          onClick: (){
                            if(movie.title != null){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => SingleMovie(movie)));
                            }else{
                                Navigator.push(context, MaterialPageRoute(builder: (context) => SingleShow(movie)));
                            }
                          },
              );
              }else{
                return Container(
                  height: 80,
                  width: 120,
                  color: Colors.black45,
                );
              }
              }
              }                     
    );
  }
}