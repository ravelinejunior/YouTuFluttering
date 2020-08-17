class Video {
  final String id;
  final String title;
  final String thumb;
  final String channel;

  //construtor
  Video({this.id, this.title, this.thumb, this.channel});

  //factory que retorna objeto do json
  factory Video.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('id'))
      return Video(
          id: json['id']['videoId'],
          title: json['snippet']['title'],
          channel: json['snippet']['channelTitle'],
          thumb: json['snippet']['thumbnails']['high']['url']);
    else
      return Video(
          id: json['videoId'],
          title: json['title'],
          thumb: json['thumb'],
          channel: json['channel']);
  }

  //transformar objeto de retorno em json
  Map<String, dynamic> toJson() {
    return {'videoId': id, 'title': title, 'thumb': thumb, 'channel': channel};
  }
}
