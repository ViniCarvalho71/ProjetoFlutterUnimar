import 'dart:convert';
import 'dart:io';

import '../models/rotas.dart';
import '../../shared/config/api_config.dart';

class RotaService {
  static Future<List<Rotas>> obterRotas() async {
    if (ApiConfig.urlBase.isEmpty) {
      throw Exception('Informe a URL da API.');
    }

    final uri = ApiConfig.montarUrl('/api/Rota');
    final client = HttpClient();

    try {
      final request = await client.getUrl(uri);
      request.headers.set(HttpHeaders.acceptHeader, 'application/json');

      final response = await request.close();
      final body = await response.transform(utf8.decoder).join();

      if (response.statusCode < 200 || response.statusCode >= 300) {
        throw Exception('Erro ${response.statusCode}: $body');
      }

      final json = jsonDecode(body);
      final lista = json is Map<String, dynamic> && json['value'] is List
          ? json['value'] as List
          : json as List;

      return lista
          .map((item) => Rotas.fromMap(item as Map<String, dynamic>))
          .toList();
    } finally {
      client.close();
    }
  }
}
