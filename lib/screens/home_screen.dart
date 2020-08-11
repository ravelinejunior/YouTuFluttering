import 'package:flutter/material.dart';
import 'package:youtubeFlutter/delegates/data_search.dart';

class HomeScreen extends StatelessWidget {
  String pesquisa = "";
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
            onPressed: () async {
              String searchResult = await showSearch(
                context: context,
                delegate: DataSearch(),
              );

              pesquisa = searchResult;
            },
            splashColor: Colors.redAccent,
          ),

          //favoritos
          IconButton(
            icon: Icon(
              Icons.star,
              color: Colors.amberAccent,
            ),
            onPressed: () {},
            splashColor: Colors.redAccent,
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
        backgroundColor: Colors.grey[800],
      ),
      body: Container(
        child: ListTile(
          title: Text(pesquisa),
          leading: Icon(Icons.cake),
        ),
      ),
    );
  }
}
