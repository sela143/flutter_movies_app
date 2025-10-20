class Movie {
  final int? id;
  final String? title;
  final String? overview;
  final String? posterPath;
  final String? releaseDate;
  final double? voteAverage;

  Movie({
    this.id,
     this.title,
     this.overview,
     this.posterPath,
     this.releaseDate,
     this.voteAverage,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'] ?? '',
      overview: json['overview'] ?? '',
      posterPath: json['poster_path'] ?? '',
      releaseDate: json['release_date'] ?? '',
      voteAverage: (json['vote_average'] ?? 0).toDouble(),
    );
  }
}
