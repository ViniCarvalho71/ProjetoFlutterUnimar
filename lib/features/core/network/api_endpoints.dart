import 'dart:io';

class ApiEndpoints {
  static const _envApiUrl = String.fromEnvironment('API_URL');

  static String get urlBase {
    if (_envApiUrl.isNotEmpty) {
      return _normalizeUrl(_envApiUrl);
    }

    if (Platform.isAndroid) {
      return 'http://10.0.2.2:5055/';
    }

    return 'http://localhost:5055/';
  }

  static String _normalizeUrl(String url) {
    return url.endsWith('/') ? url : '$url/';
  }

  static const rota = 'api/Rota';
  static const integracao = 'api/Integracao';
  static const no = 'api/No';
  static const endpoint = 'api/Endpoint';
  static const funcao = 'api/Funcao';
  static const fluxoVersionado = 'api/FluxoVersionado';
  static const logOperacao = 'api/LogOperacao';
}