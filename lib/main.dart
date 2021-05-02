import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:netflix/models/list.dart';
import 'package:netflix/screens/Download.dart';
import 'package:netflix/screens/Home.dart';
import 'package:netflix/screens/More.dart';
import 'package:netflix/screens/Search.dart';
import 'package:netflix/screens/Splash.dart';
import 'package:netflix/screens/Upcomming.dart';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  final dir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  Hive.registerAdapter(MYListAdapter());
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
       darkTheme: ThemeData(
        brightness: Brightness.dark,
        accentColor: Color(0xFF000000)
      ),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: Hive.openBox("netflix-clone"),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.done){
            if(snapshot.hasError){
              return Splash();
            }else{
              return Splash();
            }
          }else{
            return Splash();
          }
        })
    );
  }
  
  @override
  void dispose() { 
    Hive.close();
    super.dispose();
  }
}



class MyHomePage extends StatefulWidget {
  
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  List _children = [
    Home(),
    Search(),
    Upcomming(),
    Download(),
    More(),
  ];

  void _onNavChangeHandller(int index){
     setState(() {
       _selectedIndex = index;
     });
  }

  Future<bool> _backHandller()async{
    if(_selectedIndex != 0){
     setState(() {
       _selectedIndex = 0;
     });
     return false;
     
    }else{
      return true;
    }
  }


  @override
  Widget build(BuildContext context) {
   
    return WillPopScope(
          onWillPop: _backHandller,

            child: Scaffold(
              body: _children[_selectedIndex],
        
         bottomNavigationBar: BottomNavigationBar(
           backgroundColor: Color(0xFF000000),
           selectedItemColor: Colors.white,
           unselectedItemColor: Colors.white38,
           currentIndex: _selectedIndex,
           onTap: _onNavChangeHandller,
           type: BottomNavigationBarType.fixed,
           iconSize: 26.0,
           items: [
               BottomNavigationBarItem(
                 icon: Icon(Icons.home),
                 label: "Home",           
               ),
                BottomNavigationBarItem(
                 icon: Icon(Icons.search),
                 label: "Search",           
               ),
                BottomNavigationBarItem(
                 icon: Icon(Icons.shutter_speed),
                 label: "ComingSoon",           
               ),
                  BottomNavigationBarItem(
                 icon: Icon(Icons.file_download),
                 label: "Downloads",           
               ),
                  BottomNavigationBarItem(
                 icon: Icon(Icons.menu),
                 label: "More",           
               ),
           ],
         ),
      ),
             );
    
  }
}
