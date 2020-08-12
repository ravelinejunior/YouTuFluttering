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
    videos = await api.search(search);
    videosStreamControlller.sink.add(videos);
    print(videos);
  }

  @override
  void dispose() {
    videosStreamControlller.close();
    searchStreamController.close();
  }

  @override
  void addListener(listener) {
    // TODO: implement addListener
  }

  @override
  // TODO: implement hasListeners
  bool get hasListeners => throw UnimplementedError();

  @override
  void notifyListeners() {
    // TODO: implement notifyListeners
  }

  @override
  void removeListener(listener) {
    // TODO: implement removeListener
  }
}
