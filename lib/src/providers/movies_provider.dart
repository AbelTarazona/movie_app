import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_app/src/constants/api_path.dart';
import 'package:movie_app/src/models/actors_model.dart';
import 'package:movie_app/src/models/movie_model.dart';

class MoviesProvider {
  String _apiKey = API_KEY;
  String _url = API;
  String _language = "es-ES";

  int _popularsPage = 0;
  bool _loading = false;

  List<Movie> _populars = new List();

  final _popularsStreamController = StreamController<List<Movie>>.broadcast();

  Function(List<Movie>) get popularsSink => _popularsStreamController.sink.add;

  Stream<List<Movie>> get popularsStream => _popularsStreamController.stream;

  void disposeStreams() {
    _popularsStreamController?.close();
  }

  Future<List<Movie>> getMovieNowPlaying() async {
    final url = Uri.https(
        _url, NOW_PLAYING, {"api_key": _apiKey, "language": _language});

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
    if (_loading) return [];

    _loading = true;

    _popularsPage++;

    final url = Uri.https(_url, POPULAR, {
      "api_key": _apiKey,
      "language": _language,
      "page": _popularsPage.toString()
    });

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body);
      final movies = new Movies.fromJsonList(decodedData['results']);

      _populars.addAll(movies.items);
      popularsSink(_populars);

      _loading = false;

      return movies.items;
    } else {
      return [];
    }
  }

  Future<List<Actor>> getCast(String movieId) async {
    final url = Uri.https(_url, '3/movie/$movieId/credits',
        {"api_key": _apiKey, "language": _language});

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body);
      final cast = new Cast.fromJsonList(decodedData['cast']);

      return cast.actors;
    } else {
      return [];
    }
  }

  Future<List<Movie>> searchMovie(String query) async {
    final url = Uri.https(_url, '3/search/movie',
        {"api_key": _apiKey, "language": _language, "query": query});

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
