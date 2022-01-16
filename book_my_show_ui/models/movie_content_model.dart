class MovieContent {
  String imageURL;
  String movieName;
  String language;
  String quality;
  String ratings;
  String totalVotes;
  String certificate;

  MovieContent(
      {required this.certificate,
      required this.imageURL,
      required this.movieName,
      required this.language,
      required this.quality,
      required this.ratings,
      required this.totalVotes});
}
