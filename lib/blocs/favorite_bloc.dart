import 'dart:async';
import 'dart:convert';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youtubeFlutter/model/video.dart';

class FavoriteBloc implements BlocBase {
  final String KEY_FAVORITES = "FAVORITES";

  //construtor recuperando sharedpref
  FavoriteBloc() {
    SharedPreferences.getInstance().then((prefs) {
      //verificar se ja existe lista de favoritos salva
      if (prefs.getKeys().contains(KEY_FAVORITES)) {
        //retornar lista de fav e converter em map
        //mapear um mapa
        _favorites =
            json.decode(prefs.getString(KEY_FAVORITES)).map((key, video) {
          return MapEntry(key, Video.fromJson(video));
        }).cast<String, Video>();
        //adicionar o a lista ao favController
        _favController.add(_favorites);
      }
    });
  }

  Map<String, Video> _favorites = {};

  final _favController = BehaviorSubject<Map<String, Video>>.seeded({});

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

//salvar favoritos
    _saveFav();
  }

  //salvar a lista de favoritos
  void _saveFav() {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString(KEY_FAVORITES, json.encode(_favorites));
    });
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
