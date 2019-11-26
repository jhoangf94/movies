
class Peliculas {
  List<Pelicula> items = new List();

  Peliculas();

  Peliculas.fromJsonList( List<dynamic> jsonList) {
    if ( jsonList == null ) return;
    jsonList.forEach( (pelicula) => items.add(new Pelicula.fromJson(pelicula)));
  }
}


class Pelicula {
  String uniqueID;
  double popularity;
  int voteCount;
  bool video;
  String posterPath;
  int id;
  bool adult;
  String backdropPath;
  String originalLanguage;
  String originalTitle;
  List<int> genreIds;
  String title;
  double voteAverage;
  String overview;
  String releaseDate;

  Pelicula({
    this.popularity,
    this.voteCount,
    this.video,
    this.posterPath,
    this.id,
    this.adult,
    this.backdropPath,
    this.originalLanguage,
    this.originalTitle,
    this.genreIds,
    this.title,
    this.voteAverage,
    this.overview,
    this.releaseDate,
  });

  Pelicula.fromJson( Map<String, dynamic> json ) {
    popularity        = json['popularity'] / 1;
    voteCount         = json['vote_count'];
    video             = json['video'];
    posterPath        = json['poster_path'];
    id                = json['id'];
    adult             = json['adult'];
    backdropPath      = json['backdrop_path'];
    originalLanguage  = json['original_language'];
    originalTitle     = json['original_title'];
    genreIds          = json['genre_ids'].cast<int>();
    title             = json['title'];
    voteAverage       = json['vote_average'] / 1;
    overview          = json['overview'];
    releaseDate       = json['release_date'];
  }

  String getImageURL() {
    String noImageURL = 'https://altapeli.com/wp-content/uploads/2019/03/orionthemes-placeholder-image-1.png';
    String urlImage = 'https://image.tmdb.org/t/p/w500/';
    return backdropPath == null ? noImageURL :  urlImage + posterPath;
  }

  String getBackdropPathImageURL() {
    String noImageURL = 'https://altapeli.com/wp-content/uploads/2019/03/orionthemes-placeholder-image-1.png';
    String urlImage = 'https://image.tmdb.org/t/p/w500/';
    return backdropPath == null ? noImageURL :  urlImage + backdropPath;
  }
}