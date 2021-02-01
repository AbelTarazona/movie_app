class Movies {
  List<Movie> items = new List();

  Movies();

  Movies.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final movie = new Movie.fromJsonMap(item);
      items.add(movie);
    }
  }
}

class Movie {

  String uniqueId;

  bool adult;
  String backdropPath;
  List<int> genreIds;
  int id;
  String originalLanguage;
  String originalTitle;
  String overview;
  double popularity;
  String posterPath;
  String releaseDate;
  String title;
  bool video;
  double voteAverage;
  int voteCount;

  Movie.fromJsonMap(Map<String, dynamic> json)
      : adult = json["adult"],
        backdropPath = json["backdrop_path"],
        genreIds = List<int>.from(json["genre_ids"]),
        id = json["id"],
        originalLanguage = json["original_language"],
        originalTitle = json["original_title"],
        overview = json["overview"],
        popularity = json["popularity"] / 1,
        posterPath = json["poster_path"],
        releaseDate = json["release_date"],
        title = json["title"],
        video = json["video"],
        voteAverage = json["vote_average"] / 1,
        voteCount = json["vote_count"];

  getPosterImg() {

    if (posterPath != null) {
      return "https://image.tmdb.org/t/p/w500/$posterPath";
    } else {
      return 'https://www.cnij.com/wp-content/uploads/2018/09/not-available.jpg';
    }

  }

  getBackgroundImg() {

    if (backdropPath != null) {
      return "https://image.tmdb.org/t/p/w500/$backdropPath";
    } else {
      return 'https://www.cnij.com/wp-content/uploads/2018/09/not-available.jpg';
    }

  }

/*  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['adult'] = adult;
    data['backdrop_path'] = backdropPath;
    data['genre_ids'] = genreIds;
    data['id'] = id;
    data['original_language'] = originalLanguage;
    data['original_title'] = originalTitle;
    data['overview'] = overview;
    data['popularity'] = popularity;
    data['poster_path'] = posterPath;
    data['release_date'] = releaseDate;
    data['title'] = title;
    data['video'] = video;
    data['vote_average'] = voteAverage;
    data['vote_count'] = voteCount;
    return data;
  }*/
}
