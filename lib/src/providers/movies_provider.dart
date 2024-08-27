import 'dart:async';
import 'dart:convert';

import 'package:movies/src/models/actor_model.dart';
import 'package:movies/src/models/movie_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class MoviesProvider {
  final String _apiKey = dotenv.env['API_THEMOVIEDB_KEY']!;
  final String _url = 'api.themoviedb.org';
  final String _language = 'en-EN';

  int _popularPage = 0;
  bool _loadData = false;

  final List<Movie> _popular = List.empty(growable: true);
  final _popularStreamController = StreamController<List<Movie>>.broadcast();

  void disposeStream() {
    _popularStreamController.close();
  }

  Function(List<Movie>) get popularSink => _popularStreamController.sink.add;
  Stream<List<Movie>> get popularStream => _popularStreamController.stream;

    Future<List<Movie>> _processResponse(Uri url) async {
      final resp = await http.get(url);
      final decodeData = json.decode(resp.body);

      final movies = Movies.fromJsonList(decodeData['results']);

      return movies.items;
  }

  Future<List<Movie>> getNowPlaying() async {
    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key': _apiKey,
      'language': _language,
    });

    return await _processResponse(url);

  }

  Future<List<Movie>> getPopular() async {

    if (_loadData) {
      return [];
    }

    _loadData = true;

    _popularPage++;
    
    final url = Uri.https(_url, '3/movie/popular', {
      'api_key': _apiKey,
      'language': _language,
      'page': _popularPage.toString(),
    });

    final resp = await _processResponse(url);

    _popular.addAll(resp);
    popularSink(_popular);

    _loadData = false;
    
    return resp;

  }

  Future<List<Actor>> getCast(String movieId) async {
    
    final url = Uri.https(_url, '3/movie/$movieId/credits', {
      'api_key': _apiKey,
      'language': _language,
    });

    final resp = await http.get(url);
    final decodeData = json.decode(resp.body);

    final cast = Cast.fromJsonList(decodeData['cast']);
    
    return cast.actors;

  }

    Future<List<Movie>> searchMovie(String query) async {
    
    final url = Uri.https(_url, '3/search/movie', {
      'api_key': _apiKey,
      'language': _language,
      'query': query,
    });
    
    return await _processResponse(url);

  }
}