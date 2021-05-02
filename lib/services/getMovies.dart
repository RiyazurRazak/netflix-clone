import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:netflix/models/moviesData.dart';

 
class GetMovies {

 Future getMovies(url)async{

 
    final res = await http.get(Uri.parse(url));
    if(res.statusCode == 200){

      final resData = res.body;

      final jsonMap = json.decode(resData);

      final movies = Movies.fromJson(jsonMap);

    
      
      return movies;
    }
    else{
      print("error");
    }
    
  }
}