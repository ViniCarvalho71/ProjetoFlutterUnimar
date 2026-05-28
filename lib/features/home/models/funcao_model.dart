class FuncaoModel {
  final int id;
  final String nome;
  final String corpoDaFuncao;
  final String criadoEm;
  final String ultimaAlteracao;

  const FuncaoModel({
    required this.id,
    required this.nome,
    required this.corpoDaFuncao,
    required this.criadoEm,
    required this.ultimaAlteracao,
  });

  factory FuncaoModel.fromJson(Map<String, dynamic> json) {
    return FuncaoModel(
      id: _int(json, 'id'),
      nome: _string(json, 'nome'),
      corpoDaFuncao: _string(json, 'corpoDaFuncao'),
      criadoEm: _string(json, 'criadoEm'),
      ultimaAlteracao: _string(json, 'ultimaAlteracao'),
    );
  }

  int get totalLinhas {
    if (corpoDaFuncao.isEmpty) {
      return 0;
    }
    return corpoDaFuncao.split('\n').length;
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
