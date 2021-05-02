import 'package:flutter/material.dart';
import 'package:netflix/widgets/row.dart';
import 'package:html_widgets/html_widgets.dart';

class RowBuilder extends StatelessWidget {

  final String title;
  final  data;

  RowBuilder(
   this.title,
   this.data,
  );

  @override
  Widget build(BuildContext context) {
    return (
      Column(
        children: [
            H3(
              text: title,
              margin: 20,
            ),
            Container(
              height: 150,
              padding: EdgeInsets.only(left: 10.0),
              child: FutureBuilder(
                future: data,
                builder: (context, snapshot){
                  if(snapshot.hasData){
                    return Rows(snapshot);
                  }else{
                    return Container(
                      color: Colors.black54,
                    );
                  }
                },
              ),
            ),
        ]
      )
    );
  }
}