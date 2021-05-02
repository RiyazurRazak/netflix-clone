import 'package:flutter/material.dart';
import 'package:html_widgets/html_widgets.dart';
import 'package:netflix/services/getMovies.dart';
import 'package:netflix/widgets/Card.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {

  var _controller = TextEditingController();
  Future _results;
  bool showResult = false;


  _searchMovies(){
    _results = GetMovies().getMovies('https://api.themoviedb.org/3/search/movie?api_key=<<your api key>>&include_adult=true&query=${_controller.text}');
    setState(() {
      showResult = true;
    });
  }


  @override
  void dispose(){
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        children:[
          Padding(
            padding: EdgeInsets.all(20) ,
            child: TextField(
            
            controller: _controller,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              hintText: "Search...",
              contentPadding: EdgeInsets.all(20),
              border: InputBorder.none,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),  
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  Icons.search,
                  color: Color(0xFFffffff),
                  ),
                onPressed: _searchMovies,
              )
            ),
            ), 
            ),
            showResult ? 
            Container(
             height: 1200,
              child: FutureBuilder(
                future: _results,
                builder: (context, snapshot){
                    if(snapshot.hasData){
                        return ListView.builder(
                          itemCount: snapshot.data.results.length,
                          itemBuilder: (context, index){
                            final result = snapshot.data.results[index];
                            return Thumbnail('https://image.tmdb.org/t/p/w500${result.backdropPath}', result.title, result.overview, false, result);
                          });
                    }else if(snapshot.hasError){
                      return Container(
                      child: H1(
                      text: "No Results Found",
                      textAlign: "center",
                      margin: 30,
                     ),
                      );
                    }
                    else{
                       return Thumbnail('', '', '', true, '');
                    }
                }),
            )
            : Container(
              child: H1(
                text: "Search Results Appear Here",
                textAlign: "center",
                margin: 30,
              ),
            ),
        ]
      ),
    );
  }
}