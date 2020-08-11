import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:youtubeFlutter/model/video.dart';

const API_KEY = "AIzaSyB6_tXXU4IIqajs4qjgSeKHd8CUvA9AJK8";

class Api {
  //metodo de busca
  search(String search) async {
    http.Response response = await http.get(
      //codigo de requisição
      "https://www.googleapis.com/youtube/v3/search?part=snippet&q=$search&type=video&key=$API_KEY&maxResults=10",
    );
    decode(response);
  }

  //decodificador
  decode(http.Response response) {
    //verificar se dados foram recebidos
    if (response.statusCode == 200 || response.statusCode == 201) {
      //ler dados
      var decoded = json.decode(response.body);
      //transformar json em listas de videos(em forma de objetos video)
      List<Video> videos = decoded['items'].map<Video>(
        //cada map é um video, pegar um map e transformar em objeto video
        (map) {
          return Video.fromJson(map);
        },
      ).toList();

      print("Chupar e transar " + videos.toString());
    }
  }
}
