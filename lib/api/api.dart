import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:youtubeFlutter/model/video.dart';

const API_KEY = "AIzaSyA5CUC39n7taTZJQqRec3oPskdyrM7lvgc";

class Api {
  //metodo de busca
  search(String search) async {
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
}
