class NoModel {
  final int id;
  final int tipo;
  final int? funcaoId;
  final int? endPointId;
  final String? chaveValor;
  final DateTime? criadoEm;
  final DateTime? ultimaAlteracao;

  const NoModel({
    required this.id,
    required this.tipo,
    this.funcaoId,
    this.endPointId,
    this.chaveValor,
    this.criadoEm,
    this.ultimaAlteracao,
  });

  factory NoModel.fromJson(Map<String, dynamic> json) {
    return NoModel(
      id: _int(json, 'id'),
      tipo: _int(json, 'tipo'),
      funcaoId: _nullableInt(json, 'funcaoId'),
      endPointId: _nullableInt(json, 'endPointId'),
      chaveValor: _nullableString(json, 'chaveValor'),
      criadoEm: _nullableDate(json, 'criadoEm'),
      ultimaAlteracao: _nullableDate(json, 'ultimaAlteracao'),
    );
  }

  String get tipoLabel {
    switch (tipo) {
      case 1:
        return 'Requisicao';
      case 2:
        return 'Funcao';
      case 3:
        return 'Salvar Storage';
      case 4:
        return 'Pegar Storage';
      case 5:
        return 'Fluxo';
      default:
        return 'Tipo Desconhecido';
    }
  }

  String get descricaoCurta {
    if (tipo == 1 && endPointId != null) {
      return 'Endpoint #$endPointId';
    }
    if (tipo == 2 && funcaoId != null) {
      return 'Funcao #$funcaoId';
    }
    if (tipo == 3 && chaveValor != null && chaveValor!.isNotEmpty) {
      return 'Chave $chaveValor';
    }
    if (tipo == 4 && chaveValor != null && chaveValor!.isNotEmpty) {
      return 'Chave $chaveValor';
    }
    return 'No #$id';
  }

  static dynamic _valor(Map<String, dynamic> map, String nome) {
    final pascal = nome.substring(0, 1).toUpperCase() + nome.substring(1);
    return map[nome] ?? map[pascal];
  }

  static int _int(Map<String, dynamic> map, String nome) {
    final valor = _valor(map, nome);
    if (valor is int) {
      return valor;
    }
    return int.tryParse(valor?.toString() ?? '') ?? 0;
  }

  static int? _nullableInt(Map<String, dynamic> map, String nome) {
    final valor = _valor(map, nome);
    if (valor == null) {
      return null;
    }
    if (valor is int) {
      return valor;
    }
    return int.tryParse(valor.toString());
  }

  static String? _nullableString(Map<String, dynamic> map, String nome) {
    final valor = _valor(map, nome);
    if (valor == null) {
      return null;
    }
    final texto = valor.toString();
    return texto.isEmpty ? null : texto;
  }

  static DateTime? _nullableDate(Map<String, dynamic> map, String nome) {
    final valor = _valor(map, nome);
    if (valor is String && valor.isNotEmpty) {
      return DateTime.tryParse(valor);
    }
    return null;
  }
}
