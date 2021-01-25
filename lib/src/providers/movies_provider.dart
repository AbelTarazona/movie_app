import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_app/src/models/movie_model.dart';

class MoviesProvider {
  String _apiKey = "19eb744668a458ec1290b5276562cb16";
  String _url = "api.themoviedb.org";
  String _language = "es-ES";

  Future<List<Movie>> getMovieNowPlaying() async {
    final url = Uri.https(_url, "3/movie/now_playing",
        {"api_key": _apiKey, "language": _language});

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body);
      final movies = new Movies.fromJsonList(decodedData['results']);
      return movies.items;
    } else {
      return [];
    }
  }

  Future<List<Movie>> getPopular() async {
    final url = Uri.https(_url, "3/movie/popular",
        {"api_key": _apiKey, "language": _language});

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body);
      final movies = new Movies.fromJsonList(decodedData['results']);
      return movies.items;
    } else {
      return [];
    }
  }
}
