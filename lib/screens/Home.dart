import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:html_widgets/html_widgets.dart';
import 'package:netflix/models/list.dart';
import 'package:netflix/screens/Movies.dart';
import 'package:netflix/screens/MyList.dart';
import 'package:netflix/screens/SingleShow.dart';
import 'package:netflix/screens/TvShows.dart';
import 'package:netflix/services/getMovies.dart';
import 'package:netflix/services/getTvShows.dart';
import 'package:netflix/widgets/RowBuilder.dart';



class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {

  

  TabController _tabController;
  Future _popular;
  Future _trending;
  Future _topRated;
  Future _netflixOriginals;
  Future _mostRecent;
  Random random = new Random();
  int dummy;
 
 

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 4, vsync: this);
    _trending =  GetMovies().getMovies('https://api.themoviedb.org/3/trending/movie/day?api_key=<<your api key>>');
    _popular =  GetMovies().getMovies('https://api.themoviedb.org/3/movie/popular?api_key=<<your api key>>&page=1');
    _topRated =  GetMovies().getMovies('https://api.themoviedb.org/3/movie/top_rated?api_key=<<your api key>>&language=en-US&page=1');
    _netflixOriginals =  GetTvShows().getShows('https://api.themoviedb.org/3/discover/tv?api_key=<<your api key>>&with_networks=213');
    _mostRecent =  GetTvShows().getShows('https://api.themoviedb.org/3/tv/airing_today?api_key=<<your api key>>');
  }

  _addToList(movie,context){
   final box = Hive.box('netflix-clone');
   box.add(MYList(
     id: movie.id,
     title: movie.name,
     imageURL: "https://image.tmdb.org/t/p/original${movie.backdropPath}",
     ismovie: false,
     overview: movie.overview,
     popularity: movie.popularity,
   ));
    Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("${movie.name} added to List",
        style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.black,
      ));
  }



  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
       appBar: PreferredSize(
                        preferredSize: Size.fromHeight(kToolbarHeight),
                        child: Container(
                          child: SafeArea(
                            child: 
                                 TabBar(
                                   controller: _tabController,
                                   isScrollable: true,
                                   indicatorColor: Colors.transparent,
                                   indicatorPadding: EdgeInsets.zero,
                                    tabs:[
                                      Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Image.network(
                                        "https://pngimg.com/uploads/netflix/netflix_PNG15.png",
                                        width: 20,
                                        height: 40,
                                       ),
                                       ),
                                       Tab(
                                         text: "TV Shows"
                                       ),
                                        Tab(
                                         text: "Movies"
                                       ),
                                        Tab(
                                         text: "My List"
                                       ),
                                    ]
                                  ),
                            ),
                          ),
                        ),
                

                 body: TabBarView(
                   controller: _tabController,
                   physics: NeverScrollableScrollPhysics(),
                   children: [
                     SingleChildScrollView(
                       scrollDirection: Axis.vertical,
                    child :
                     Column(
                       children:[
                          FutureBuilder(
                             future: _netflixOriginals,
                             builder: (context, snapshot){
                               if(snapshot.hasData){
                                 final randomShow = snapshot.data.results[random.nextInt(20)];
                                  return Stack(
                                    children: [
                                      HtmlImage(src: "https://image.tmdb.org/t/p/original${randomShow.backdropPath}",
                                      height: 450,
                                      width: MediaQuery.of(context).size.width * 1.0,
                                      size: "cover",
                                     ),
                                    Container(
                                       height: 450,
                                       padding: EdgeInsets.only(bottom:30),
                                       color: Colors.black45,
                                       alignment: Alignment.bottomCenter,
                                        child:Column(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            H1(
                                             text: randomShow.name,
                                             textAlign: "center",
                                             fontWeight: 900,
                                             fontSize: 40,
                                             margin: 10,
                                            ),
                                             Row(
                                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                                               children: [
                                                 Column(
                                                   children:[
                                                    IconButton(
                                                    icon: Icon(Icons.add), 
                                                    onPressed: (){
                                                      _addToList(randomShow, context);
                                                    }
                                                  ),
                                                  Text("My List")
                                                   ]
                                                 ),
                                                 ElevatedButton(
                                                     onPressed: (){
                                                       Navigator.push(context, MaterialPageRoute(builder: (context) => SingleShow(randomShow))); 
                                                     },
                                                     child: Row(
                                                       children: [
                                                         Icon(Icons.play_arrow,
                                                         color: Color(0xFF000000),
                                                         ),
                                                         Text(
                                                         "Play",
                                                          style: TextStyle(
                                                           color: Color(0xFF000000)
                                                       ),
                                                     ),
                                                       ]),
                                                        style: ButtonStyle(
                                                       backgroundColor: MaterialStateProperty.all(Colors.white)
                                                     ),
                                                    ),
                                                    
                                                  Column(
                                                   children:[
                                                    IconButton(
                                                    icon: Icon(Icons.info_outline), 
                                                    onPressed: (){
                                                      Navigator.push(context, MaterialPageRoute(builder: (context) => SingleShow(randomShow)));
                                                    }
                                                  ),
                                                  Text("Info")
                                                   ]
                                                 )
                                                 
                                               ],
                                             ),
                                           ],
                                           ) 
                                    )
                                   ],
                                   );
                                }else{
                                  return Container(
                                    height: 450,
                                    color: Colors.black54,
                                  );
                                }
                           
                        }),
                        RowBuilder("Popular On Netflix", _popular),
                        RowBuilder("Netflix Originals", _netflixOriginals),
                        RowBuilder("Recent", _mostRecent),
                        RowBuilder("Trending Now", _trending),
                        RowBuilder("Top Rated", _topRated),
                        H5(
                          text: "Developed By Riyazur Razak",
                          margin: 20,
                          textAlign: "center",
                        )
                     ],
                     ),
                     ),
                     TVShows(),
                     MoviesPage(),
                    MyList()
                   ],
                   )
                            
    );
  }


}