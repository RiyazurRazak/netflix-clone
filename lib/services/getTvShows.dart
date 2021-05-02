import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:netflix/models/tvshowData.dart';



class GetTvShows {

 Future getShows(url)async{
    final res = await http.get(Uri.parse(url));
    if(res.statusCode == 200){

      final resData = res.body;

      final jsonMap = json.decode(resData);

      final tvshows = TvShows.fromJson(jsonMap);
      
      return tvshows;
    }
  }
}