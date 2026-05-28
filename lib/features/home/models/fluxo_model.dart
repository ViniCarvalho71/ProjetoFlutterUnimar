import 'dart:convert';

import 'fluxo_payload_model.dart';

class FluxoModel {
  final int fluxoId;
  final String nome;
  final int versao;
  final FluxoPayloadModel payload;
  final bool atual;
  final int id;
  final DateTime criadoEm;
  final DateTime ultimaAlteracao;

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
    final payloadJson = jsonDecode(json['payload'] as String);

    return FluxoModel(
      fluxoId: json['fluxoId'] as int,
      nome: json['nome'] as String,
      versao: json['versao'] as int,
      payload: FluxoPayloadModel.fromJson(payloadJson as Map<String, dynamic>),
      atual: json['atual'] as bool,
      id: json['id'] as int,
      criadoEm: DateTime.parse(json['criadoEm'] as String),
      ultimaAlteracao: DateTime.parse(json['ultimaAlteracao'] as String),
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
      'criadoEm': criadoEm.toIso8601String(),
      'ultimaAlteracao': ultimaAlteracao.toIso8601String(),
    };
  }
}