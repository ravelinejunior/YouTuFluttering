import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:youtubeFlutter/blocs/favorite_bloc.dart';

import 'package:youtubeFlutter/blocs/videos_bloc.dart';
import 'package:youtubeFlutter/screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      blocs: [
        Bloc((i) => VideosBloc()),
        Bloc((j) => FavoriteBloc()),
      ],
      child: MaterialApp(
        title: 'RaveTube',
        theme: ThemeData(
          primarySwatch: Colors.red,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
        darkTheme: ThemeData.dark(),
      ),
    );
  }
}
