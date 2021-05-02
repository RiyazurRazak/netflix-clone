import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:netflix/models/videoData.dart';



class GetVideo {

 Future getVideo(url)async{
    final res = await http.get(Uri.parse(url));
    if(res.statusCode == 200){

      final resData = res.body;

      final jsonMap = json.decode(resData);

      final videos = Video.fromJson(jsonMap);
      
      return videos;
    }
  }
}