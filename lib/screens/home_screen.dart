import 'package:flutter/material.dart';
import 'package:youtubeFlutter/delegates/data_search.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          //pesquisar
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {
              showSearch(
                context: context,
                delegate: DataSearch(),
              );
            },
            splashColor: Colors.black,
          ),

          //favoritos
          IconButton(
            icon: Icon(
              Icons.star,
              color: Colors.amberAccent,
            ),
            onPressed: () {},
            splashColor: Colors.black,
          ),

          Container(
            padding: EdgeInsets.only(right: 16),
            child: Align(
              alignment: Alignment.center,
              child: Text("0"),
            ),
          ),
        ],
        title: Row(
          children: <Widget>[
            //imagem
            Container(
              height: 50.0,
              child: Image.asset("images/logoyoutube.jpg"),
            ),

            //texto
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "RaveTube.com",
                  overflow: TextOverflow.fade,
                ),
              ),
            ),
          ],
        ),
        elevation: 0,
        backgroundColor: Colors.black54,
      ),
      body: Container(),
    );
  }
}
