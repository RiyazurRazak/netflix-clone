import 'package:flutter/material.dart';
import 'package:html_widgets/html_widgets.dart';

class More extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child :Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            H2(
              text: "Created By Riyazur Razak",
              margin: 30,
              textAlign: "center",
            ),
            P(
              text: "*All The Data Was Provided By tmdb api",
              textAlign: "center",
            )
          ]
        ),
      )
    );
    
  }
}