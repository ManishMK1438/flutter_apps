class GIF {
  String id;
  String title;
  String url;

  GIF({required this.title, required this.id, required this.url});

  factory GIF.fromJson(dynamic json){
    return GIF(title: json['title'], id: json['id'], url: json['images']['original']['url']);
  }
/*
  static GIF mapToObject(Map<String, dynamic> json) {
    return GIF(
        title: json['title'],
        url: json['images']['original']['url'],
        id: json['id']);
  }*/
}
