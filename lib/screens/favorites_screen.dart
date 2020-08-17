import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_youtube/flutter_youtube.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:youtubeFlutter/api/api.dart';
import 'package:youtubeFlutter/blocs/favorite_bloc.dart';
import 'package:youtubeFlutter/model/video.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //chamar o bloc
    final blocProvider = BlocProvider.getBloc<FavoriteBloc>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Favoritos'),
        centerTitle: true,
        backgroundColor: Colors.redAccent[700],
      ),
      body: StreamBuilder<Map<String, Video>>(
        //toda vez que houver alteração no favoritos ele rebuilda a tela de favoritos
        stream: blocProvider.outFav,
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.redAccent),
            );
          else
            return ListView(
              //retornar mapa de favoritos
              children: snapshot.data.values.map((value) {
                return Card(
                  elevation: 5,
                  shadowColor: Colors.blue,
                  child: InkWell(
                    splashColor: Colors.orangeAccent,
                    child: Row(
                      children: [
                        Card(
                          color: Colors.black,
                          borderOnForeground: true,
                          elevation: 10,
                          child: Container(
                            width: 200,
                            height: 200,
                            padding: const EdgeInsets.all(8),
                            child: FadeInImage.memoryNetwork(
                              placeholder: kTransparentImage,
                              image: value.thumb,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              value.title,
                              overflow: TextOverflow.fade,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              maxLines: 2,
                            ),
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      FlutterYoutube.playYoutubeVideoById(
                          apiKey: API_KEY,
                          videoId: value.id,
                          fullScreen: true,
                          autoPlay: true);
                    },
                    onLongPress: () {
                      blocProvider.toggleFavorite(value);
                    },
                  ),
                );
              }).toList(),
            );
        },
      ),
    );
  }
}
