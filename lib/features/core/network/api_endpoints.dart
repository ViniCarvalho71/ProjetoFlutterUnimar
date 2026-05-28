import 'dart:io';

class ApiEndpoints {
  static String get urlBase {
    if (Platform.isAndroid) {
      return 'http://10.0.2.2:5055/';
    }

    if (Platform.isIOS) {
      return 'http://localhost:5055/';
    }

    return 'http://localhost:5055/';
  }

  static const rota = 'api/Rota';
  static const integracao = 'api/Integracao';
  static const no = 'api/No';
  static const endpoint = 'api/Endpoint';
  static const funcao = 'api/Funcao';
  static const fluxoVersionado = 'api/FluxoVersionado';
  static const logOperacao = 'api/LogOperacao';
}