class PeliDetalle {
  MovieDetails pelicula;

  PeliDetalle.fromJson(dynamic json) {
    if (json == null) return;
    pelicula = MovieDetails.fromJsonMap(json);
  }
}

class Genres {
  int id;
  String name;

  Genres({this.id, this.name});

  factory Genres.fromJson(Map<String, dynamic> genre) {
    return Genres(id: genre['id'], name: genre['name']);
  }
}

class MovieDetails {
  bool adult;
  String backdropPath;
  dynamic belongsToCollection;
  int budget;
  List genres;
  String homepage;
  int id;
  String imdbId;
  String originalLanguage;
  String originalTitle;
  String overview;
  double popularity;
  String posterPath;
  List productionCompanies;
  List productionCountries;
  String releaseDate;
  int revenue;
  int runtime;
  List spokenLanguages;
  String status;
  String tagline;
  String title;
  bool video;
  double voteAverage;
  int voteCount;

  MovieDetails({
    this.adult,
    this.backdropPath,
    this.belongsToCollection,
    this.budget,
    this.genres,
    this.homepage,
    this.id,
    this.imdbId,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.productionCompanies,
    this.productionCountries,
    this.releaseDate,
    this.revenue,
    this.runtime,
    this.spokenLanguages,
    this.status,
    this.tagline,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

  factory MovieDetails.fromJsonMap(Map<String, dynamic> json) {
    if (json['genres'] == null) {
      json['genres'] = [
        {'id': 12345, 'name': 'indefinido'}
      ];
    }
    var list = json['genres'] as List;
    List<Genres> genresList =
        list.map((genre) => Genres.fromJson(genre)).toList();
    return MovieDetails(
        adult: json['adult'],
        backdropPath: json['backdrop_path'],
        belongsToCollection: json['belongs_to_collection'],
        budget: json['budget'],
        genres: genresList,
        homepage: json['homepage'],
        id: json['id'],
        imdbId: json['imdb_id'],
        originalLanguage: json['original_language'],
        originalTitle: json['original_title'],
        overview: json['overview'],
        popularity: json['popularity'],
        posterPath: json['poster_path'],
        productionCompanies: json['production_companies'],
        productionCountries: json['production_countries'],
        releaseDate: json['release_date'],
        revenue: json['revenue'],
        runtime: json['runtime'],
        spokenLanguages: json['spoken_languages'],
        status: json['status'],
        tagline: json['tagline'],
        title: json['title'],
        video: json['video'],
        voteAverage: json['vote_average'],
        voteCount: json['vote_count']);
  }
  getPosterImage() {
    if (posterPath == null) {
      return 'https://www.lauriloewenberg.com/wp-content/uploads/2019/04/No_Image_Available.jpg';
    } else {
      return 'https://image.tmdb.org/t/p/w500/$posterPath';
    }
  }

  getBackgroundImage() {
    if (backdropPath == null) {
      return 'https://www.lauriloewenberg.com/wp-content/uploads/2019/04/No_Image_Available.jpg';
    } else {
      return 'https://image.tmdb.org/t/p/w500/$backdropPath';
    }
  }
}
