class Video {
  final String id;
  final String title;
  final String thumb;
  final String channel;

  //construtor
  Video({this.id, this.title, this.thumb, this.channel});

  //factory que retorna objeto do json
  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      id: json['id']['videoId'],
      title: json['snippet']['title'],
      channel: json['snippet']['channelTitle'],
      thumb: json['snippet']['thumbnails']['high']['url'],
    );
  }
}
