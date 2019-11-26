import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:peliculas/src/models/actor_model.dart';
import 'package:peliculas/src/providers/base_provider.dart';

class ActorsProvider extends BaseProvider {

  Future<List<Actor>> _getResponse(Uri url) async {
    try {
      final result = await http.get(url);
      final resDecoded = json.decode(result.body);
      final actors = Actors.fromJsonList(resDecoded['cast']);
      return actors.list;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<List<Actor>> getActors(String movieId) async {
    final params = getQueryParams();
    params['movie_id'] = movieId;
    final url = Uri.https(apiUrl, '3/movie/$movieId/credits', params);
    final result = await _getResponse(url);
    return result;
  }
}
