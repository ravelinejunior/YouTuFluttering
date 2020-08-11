import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DataSearch extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    // botoes a direita durante pesquisa

    return [
      //para fechar e deletar o texto digitado
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // fica no canto esquerdo quando for pesquisar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        Future.delayed(Duration(seconds: 2));
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    Future.delayed(Duration.zero).then((value) => close(context, query));
    debugPrint(query);
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty)
      return Container();
    else
      return FutureBuilder<List>(
        future: suggestions(query),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.redAccent),
              ),
            );
          } else {
            return ListView.builder(
              itemBuilder: (context, index) {
                //chamado para cada item criado e encontrado
                return ListTile(
                  title: Text(snapshot.data[index]),
                  leading: Icon(Icons.play_arrow),
                  onTap: () {
                    close(context, snapshot.data[index]);
                  },
                );
              },
              itemCount: snapshot.data.length,
            );
          }
        },
      );
  }

  //exibir sugestoes
  Future<List> suggestions(String search) async {
    final String urlSuggestion =
        "http://suggestqueries.google.com/complete/search?hl=en&ds=yt&client=youtube&hjson=t&cp=1&q=$search&format=5&alt=json";

    http.Response response = await http.get(urlSuggestion);

    if (response.statusCode == 200) {
      return json.decode(response.body)[1].map((v) {
        return v[0];
      }).toList();
    } else {
      throw Exception("Failed to load suggestions");
    }
  }
}
