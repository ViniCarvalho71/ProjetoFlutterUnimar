class IntegracaoModel {
  final int id;
  final String nome;
  final String url;
  final String descricao;
  final String criadoEm;
  final String ultimaAlteracao;

  const IntegracaoModel({
    required this.id,
    required this.nome,
    required this.url,
    required this.descricao,
    required this.criadoEm,
    required this.ultimaAlteracao,
  });

  factory IntegracaoModel.fromJson(Map<String, dynamic> json) {
    return IntegracaoModel(
      id: _int(json, 'id'),
      nome: _string(json, 'nome'),
      url: _string(json, 'url'),
      descricao: _string(json, 'descricao'),
      criadoEm: _string(json, 'criadoEm'),
      ultimaAlteracao: _string(json, 'ultimaAlteracao'),
    );
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
