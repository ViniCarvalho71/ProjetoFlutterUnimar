import 'integracao_model.dart';

class EndpointModel {
  final int id;
  final String recurso;
  final int integracaoId;
  final int verbo;
  final String descricao;
  final String criadoEm;
  final String ultimaAlteracao;
  final IntegracaoModel? integracao;

  const EndpointModel({
    required this.id,
    required this.recurso,
    required this.integracaoId,
    required this.verbo,
    required this.descricao,
    required this.criadoEm,
    required this.ultimaAlteracao,
    this.integracao,
  });

  factory EndpointModel.fromJson(Map<String, dynamic> json) {
    final integracaoJson = _valor(json, 'integracao');

    return EndpointModel(
      id: _int(json, 'id'),
      recurso: _string(json, 'recurso'),
      integracaoId: _int(json, 'integracaoId'),
      verbo: _int(json, 'verbo'),
      descricao: _string(json, 'descricao'),
      criadoEm: _string(json, 'criadoEm'),
      ultimaAlteracao: _string(json, 'ultimaAlteracao'),
      integracao: integracaoJson is Map<String, dynamic>
          ? IntegracaoModel.fromJson(integracaoJson)
          : null,
    );
  }

  EndpointModel copyWith({IntegracaoModel? integracao}) {
    return EndpointModel(
      id: id,
      recurso: recurso,
      integracaoId: integracaoId,
      verbo: verbo,
      descricao: descricao,
      criadoEm: criadoEm,
      ultimaAlteracao: ultimaAlteracao,
      integracao: integracao ?? this.integracao,
    );
  }

  String get verboLabel {
    switch (verbo) {
      case 1:
        return 'GET';
      case 2:
        return 'POST';
      case 3:
        return 'PUT';
      case 4:
        return 'DELETE';
      case 5:
        return 'PATCH';
      default:
        return verbo == 0 ? 'HTTP' : 'HTTP $verbo';
    }
  }
}

dynamic _valor(Map<String, dynamic> map, String nome) {
  final pascal = nome.substring(0, 1).toUpperCase() + nome.substring(1);
  return map[nome] ?? map[pascal];
}

String _string(Map<String, dynamic> map, String nome) {
  final valor = _valor(map, nome);
  return valor == null ? '' : valor.toString();
}

int _int(Map<String, dynamic> map, String nome) {
  final valor = _valor(map, nome);
  if (valor is int) {
    return valor;
  }
  return int.tryParse(valor?.toString() ?? '') ?? 0;
}
