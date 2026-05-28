class ApiConfig {
  static const String urlBase = 'https://beats-urw-figured-season.trycloudflare.com';

  static Uri montarUrl(String caminho) {
    return Uri.parse('$urlBase$caminho');
  }
}
