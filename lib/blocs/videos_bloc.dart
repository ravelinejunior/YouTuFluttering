import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:youtubeFlutter/api/api.dart';
import 'package:youtubeFlutter/model/video.dart';

class VideosBloc implements BlocBase {
  Api api;
  List<Video> videos;
  final StreamController<List<Video>> videosStreamControlller =
      StreamController<List<Video>>();
  final StreamController<String> searchStreamController =
      StreamController<String>();

  //getter
  Stream get outVideos => videosStreamControlller.stream;
  Sink get inSearch => searchStreamController.sink;

  VideosBloc() {
    api = Api();

    //recuperar valores passados no search controller atraves do sink
    searchStreamController.stream.listen(_search);
  }

//função de busca de videos
  void _search(String search) async {
    if (search != null) {
      //enviar uma lista vazia para quando houver uma nova pesquisa, começar do zero
      videosStreamControlller.sink.add([]);
      videos = await api.search(search);
    } else {
      //retorna proximos 10 livros
      videos += await api.nextPage();
    }

    videosStreamControlller.sink.add(videos);
  }

  @override
  void dispose() {
    videosStreamControlller.close();
    searchStreamController.close();
  }

  @override
  void addListener(listener) {}

  @override
  bool get hasListeners => throw UnimplementedError();

  @override
  void notifyListeners() {}

  @override
  void removeListener(listener) {}
}

@override
bool get hasListeners => throw UnimplementedError();

@override
void notifyListeners() {}

@override
void removeListener(listener) {}
