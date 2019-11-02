class Peliculas {
  List<Pelicula> items = new List();

  Peliculas();

  Peliculas.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final pelicula = new Pelicula.fromJsonMap(item);
      items.add(pelicula);
    }
  }
}

class Pelicula {
  String uniqueId;
  int voteCount;
  int id;
  bool video;
  double voteAverage;
  String title;
  double popularity;
  String posterPath;
  String originalLanguage;
  String originalTitle;
  List<int> genreIds;
  String backdropPath;
  bool adult;
  String overview;
  String releaseDate;

  Pelicula({
    this.voteCount,
    this.id,
    this.video,
    this.voteAverage,
    this.title,
    this.popularity,
    this.posterPath,
    this.originalLanguage,
    this.originalTitle,
    this.genreIds,
    this.backdropPath,
    this.adult,
    this.overview,
    this.releaseDate,
  });

  factory Pelicula.fromJsonMap(Map<String, dynamic> json) {
    double voteAverage;
    double popularity;
    if (json['vote_average'] == null) {
      voteAverage = 0;
    } else {
      voteAverage = json['vote_average'] / 1;
    }
    if (json['popularity'] == null) {
      popularity = 0;
    } else {
      popularity = json['popularity'] / 1;
    }

    return Pelicula(
        voteCount: json['vote_count'],
        id: json['id'],
        video: json['video'],
        voteAverage: voteAverage,
        title: json['title'],
        popularity: popularity,
        posterPath: json['poster_path'],
        originalLanguage: json['original_language'],
        originalTitle: json['original_title'],
        genreIds: json['genre_ids'].cast<int>(),
        backdropPath: json['backdrop_path'],
        adult: json['adult'],
        overview: json['overview'],
        releaseDate: json['release_date']);
  }
  getPosterImage() {
    if (posterPath == null) {
      return 'https://www.lauriloewenberg.com/wp-content/uploads/2019/04/No_Image_Available.jpg';
    } else {
      return 'https://image.tmdb.org/t/p/w500/$posterPath';
    }
  }

  getBackgroundImage() {
    if (posterPath == null) {
      return 'https://www.lauriloewenberg.com/wp-content/uploads/2019/04/No_Image_Available.jpg';
    } else {
      return 'https://image.tmdb.org/t/p/w500/$backdropPath';
    }
  }
}
