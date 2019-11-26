import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:peliculas/src/providers/base_provider.dart';

class PeliculasProvider extends BaseProvider {
  int _pageNumber = 0;
  bool _loading = false;
  Map<String, String> queryParams;
  List<Pelicula> _populares = new List();

  final _pageStreamController =
      new StreamController<List<Pelicula>>.broadcast();
  void Function(List<Pelicula>) get popularesSink =>
      _pageStreamController.sink.add;
  Stream<List<Pelicula>> get popularesStream => _pageStreamController.stream;

  void disposeStreams() {
    _pageStreamController?.close();
  }

  Future<List<Pelicula>> _getReponse(Uri url) async {
    final response = await http.get(url);
    final decodeData = json.decode(response.body);
    final List<dynamic> results = decodeData['results'];
    final peliculas = Peliculas.fromJsonList(results);
    return peliculas.items;
  }

  Future<List<Pelicula>> getInCinemas() {
    Uri url = Uri.https(apiUrl, '/3/movie/now_playing', {
      'api_key': apiKey,
      'language': lang,
    });

    return _getReponse(url);
  }

  void getPopulars() async {
    if (!_loading) {
      _loading = true;
      _pageNumber++;

      Map<String, String> params = getQueryParams();
      params['page'] = _pageNumber.toString();

      Uri url = Uri.https(apiUrl, '/3/movie/popular', params);

      final peliculas = await _getReponse(url);
      _loading = false;

      _populares.addAll(peliculas);
      popularesSink(_populares);
    }
  }
}
