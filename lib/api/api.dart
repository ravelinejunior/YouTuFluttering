import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:youtubeFlutter/model/video.dart';

//const API_KEY = "AIzaSyA5CUC39n7taTZJQqRec3oPskdyrM7lvgc";
const API_KEY = "AIzaSyAUwpa_isNogR-z2xGZ8m6mQND1XXKyxmA";

class Api {
  String _search;
  String _nextToken;

  //metodo de busca
  search(String search) async {
    //recuperar texto predigitado
    _search = search;

    http.Response response = await http.get(
      //codigo de requisição
      "https://www.googleapis.com/youtube/v3/search?part=snippet&q=$search&type=video&key=$API_KEY&maxResults=10",
    );
    return decode(response);
  }

  //decodificador
  List<Video> decode(http.Response response) {
    //verificar se dados foram recebidos
    if (response.statusCode == 200) {
      //ler dados
      var decoded = json.decode(response.body);

      //recuperando token de paginação
      _nextToken = decoded['nextPageToken'];

      //transformar json em listas de videos(em forma de objetos video)
      List<Video> videos = decoded['items'].map<Video>(
        //cada map é um video, pegar um map e transformar em objeto video
        (map) {
          return Video.fromJson(map);
        },
      ).toList();

      return videos;
    } else {
      throw Exception("Failed to load videos");
    }
  }

  //carregar paginação
  Future<List<Video>> nextPage() async {
    http.Response response = await http.get(
      //codigo de requisição
      "https://www.googleapis.com/youtube/v3/search?part=snippet&q=$_search&type=video&key=$API_KEY&maxResults=10&pageToken=$_nextToken",
    );
    return decode(response);
  }
}
