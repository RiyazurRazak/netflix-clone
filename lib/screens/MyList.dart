import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:html_widgets/html_widgets.dart';
import 'package:netflix/models/list.dart';
import 'package:netflix/models/moviesData.dart';
import 'package:netflix/models/tvshowData.dart';
import 'package:netflix/screens/SingleMovie.dart';
import 'package:netflix/screens/SingleShow.dart';


class MyList extends StatelessWidget {


  _deleteList(index){
    final box = Hive.box('netflix-clone');
    box.deleteAt(index);
  }

  _redirect(context ,movie){
      if(movie.ismovie == true){
        final mov = Result(
            id: movie.id,
            title: movie.title,
            overview: movie.overview,
            backdropPath: movie.imageURL,
            popularity: movie.popularity,
            );
        Navigator.push(context, MaterialPageRoute(builder: (context) => SingleMovie(mov)));
        }
        else{
           final show = Results(
           id: movie.id,
           name: movie.title,
           overview: movie.overview,
           backdropPath: movie.imageURL,
           popularity: movie.popularity,
          );
          Navigator.push(context, MaterialPageRoute(builder: (context) => SingleShow(show)));
      }
  }
  @override
  Widget build(BuildContext context) {
    return WatchBoxBuilder(
      box: Hive.box("netflix-clone"), 
      builder: (context, box){
           if(box.length > 0){
              return 
              ListView.builder(
                itemCount: box.length,
                itemBuilder: (context, index){
                  final movie = box.getAt(index) as MYList;
                  return GestureDetector(
                    onTap: (){
                      _redirect(context, movie);
                    },
                    onDoubleTap: (){
                      _deleteList(index);
                    },
                     child: Padding(
                     padding: EdgeInsets.all(5),  
                     child: Row(
                       children: [
                        Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: HtmlImage(
                          src: movie.imageURL,
                          height: 100,
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Column(
                          children: [
                            H3(
                              text: movie.title,
                              margin: 20,
                            ),
                          ]
                        ),
                      )
                    ],
                  ),),);
                },
              );
           }else{
             return Container();
           }
      });
  }
}