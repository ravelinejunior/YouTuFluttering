import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:youtubeFlutter/blocs/favorite_bloc.dart';

import 'package:youtubeFlutter/model/video.dart';

class VideoTile extends StatelessWidget {
  final Video video;
  VideoTile(this.video);
  final bloc = BlocProvider.getBloc<FavoriteBloc>();

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      margin: const EdgeInsets.symmetric(vertical: 4),
      color: Colors.grey[900],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          //videos
          AspectRatio(
            aspectRatio: 16 / 9,
            child: FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: video.thumb,
              fit: BoxFit.cover,
            ),
          ),

          //info dos textos
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //titulo
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                      child: Text(
                        video.title,
                        maxLines: 2,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    //canal
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        video.channel,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //favoritar
              StreamBuilder<Map<String, Video>>(
                stream: bloc.outFav,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                      ),
                    );
                  } else {
                    return IconButton(
                      splashColor: Colors.amber,
                      icon: Icon(
                        snapshot.data.containsKey(video.id)
                            ? Icons.star
                            : Icons.star_border,
                        color: Colors.amberAccent,
                        size: 30,
                      ),
                      onPressed: () {
                        //atualizar
                        bloc.toggleFavorite(video);
                      },
                    );
                  }
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
