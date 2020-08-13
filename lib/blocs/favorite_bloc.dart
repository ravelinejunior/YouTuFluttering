import 'dart:async';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:youtubeFlutter/model/video.dart';

class FavoriteBloc implements BlocBase {
  Map<String, Video> _favorites = {};

  final StreamController<Map<String, Video>> _favController =
      StreamController<Map<String, Video>>.broadcast();

  Stream<Map<String, Video>> get outFav => _favController.stream;

  //função de marcar e desmarcar
  void toggleFavorite(Video video) {
    //verificar se video ja está la
    if (_favorites.containsKey(video.id))
      _favorites.remove(video.id);
    else
      _favorites[video.id] = video;

    //enviar para o sink
    _favController.sink.add(_favorites);
  }

  @override
  void addListener(listener) {}

  @override
  void dispose() {
    _favController.close();
  }

  @override
  bool get hasListeners => throw UnimplementedError();

  @override
  void notifyListeners() {}

  @override
  void removeListener(listener) {}
}
