class BaseProvider {
  String apiKey = '722ee383461b05037f58d4c09e1bd11a';
  String lang = 'es-ES';
  String apiUrl = 'api.themoviedb.org';

   Map<String, String> getQueryParams() {
    return {'api_key': apiKey, 'language': lang};
  }
}