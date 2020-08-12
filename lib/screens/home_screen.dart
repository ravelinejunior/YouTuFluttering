import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:youtubeFlutter/blocs/videos_bloc.dart';
import 'package:youtubeFlutter/delegates/data_search.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String pesquisa = "Empty";

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
            splashColor: Colors.redAccent,
            onPressed: () async {
              String searchResult =
                  await showSearch(context: context, delegate: DataSearch());
              if (searchResult != null)
                BlocProvider.getBloc<VideosBloc>().inSearch.add(searchResult);
              pesquisa = searchResult;
            },
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
      body: StreamBuilder(
        stream: BlocProvider.getBloc<VideosBloc>().outVideos,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.redAccent),
              ),
            );
          } else {
            return ListView.builder(itemBuilder: null);
          }
        },
      ),
    );
  }
}
