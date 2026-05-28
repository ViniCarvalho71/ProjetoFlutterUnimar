import 'dart:convert';

import 'fluxo_payload_model.dart';

class FluxoModel {
  final int fluxoId;
  final String nome;
  final int versao;
  final FluxoPayloadModel payload;
  final bool atual;
  final int id;
  final DateTime? criadoEm;
  final DateTime? ultimaAlteracao;

  const FluxoModel({
    required this.fluxoId,
    required this.nome,
    required this.versao,
    required this.payload,
    required this.atual,
    required this.id,
    required this.criadoEm,
    required this.ultimaAlteracao,
  });

  factory FluxoModel.fromJson(Map<String, dynamic> json) {
    return FluxoModel(
      fluxoId: _int(json, 'fluxoId'),
      nome: _string(json, 'nome'),
      versao: _int(json, 'versao'),
      payload: FluxoPayloadModel.fromJson(_payloadMap(json)),
      atual: _bool(json, 'atual'),
      id: _int(json, 'id'),
      criadoEm: _nullableDate(json, 'criadoEm'),
      ultimaAlteracao: _nullableDate(json, 'ultimaAlteracao'),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fluxoId': fluxoId,
      'nome': nome,
      'versao': versao,
      'payload': jsonEncode(payload.toJson()),
      'atual': atual,
      'id': id,
      'criadoEm': criadoEm?.toIso8601String(),
      'ultimaAlteracao': ultimaAlteracao?.toIso8601String(),
    };
  }

  static Map<String, dynamic> _payloadMap(Map<String, dynamic> map) {
    final valor = _valor(map, 'payload');
    if (valor is Map<String, dynamic>) {
      return valor;
    }
    if (valor is Map) {
      return Map<String, dynamic>.from(valor);
    }
    if (valor is String && valor.trim().isNotEmpty) {
      try {
        final decoded = jsonDecode(valor);
        if (decoded is Map<String, dynamic>) {
          return decoded;
        }
        if (decoded is Map) {
          return Map<String, dynamic>.from(decoded);
        }
      } on FormatException {
        return const {};
      }
    }
    return const {};
  }

  static dynamic _valor(Map<String, dynamic> map, String nome) {
    final pascal = nome.substring(0, 1).toUpperCase() + nome.substring(1);
    return map[nome] ?? map[pascal];
  }

  static String _string(Map<String, dynamic> map, String nome) {
    final valor = _valor(map, nome);
    return valor == null ? '' : valor.toString();
  }

  static int _int(Map<String, dynamic> map, String nome) {
    final valor = _valor(map, nome);
    if (valor is int) {
      return valor;
    }
    return int.tryParse(valor?.toString() ?? '') ?? 0;
  }

  static bool _bool(Map<String, dynamic> map, String nome) {
    final valor = _valor(map, nome);
    if (valor is bool) {
      return valor;
    }
    if (valor is int) {
      return valor == 1;
    }
    return valor?.toString().toLowerCase() == 'true';
  }

  static DateTime? _nullableDate(Map<String, dynamic> map, String nome) {
    final valor = _valor(map, nome);
    if (valor is DateTime) {
      return valor;
    }
    if (valor is String && valor.isNotEmpty) {
      return DateTime.tryParse(valor);
    }
    return null;
  }
}
