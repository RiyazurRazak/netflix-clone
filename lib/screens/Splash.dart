import 'package:flutter/material.dart';
import 'dart:async';

import 'package:netflix/main.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState() { 
    super.initState();
    Timer(
        Duration(seconds: 3),
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => MyHomePage())));
  }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/background.jpg'),
                fit: BoxFit.cover
              )
            ),
          ),
          Container(
            color: Colors.black54,
          ),
          Center(
            child: Image.asset(
              'images/logo.png',
              fit: BoxFit.contain,
              alignment: Alignment.center,
            ),
          )
        ],
      ) 
     
    );
  }
  }
