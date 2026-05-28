class Rotas {
  int id;
  String nome;
  String caminho;
  String metodo;
  String descricao;
  String senhaAcesso;
  bool usarFluxoMaisAtual;
  bool rateLimit;
  int rateLimitRequests;
  int rateLimitInterval;
  bool idempotencia;
  String jsonSchemaResp;
  String jsonSchemaReq;
  int pipelineVersaoId;
  String pipelineVersao;
  String criadoEm;
  String ultimaAlteracao;

  Rotas({
    required this.id,
    required this.nome,
    required this.caminho,
    required this.metodo,
    required this.descricao,
    required this.senhaAcesso,
    required this.usarFluxoMaisAtual,
    required this.rateLimit,
    required this.rateLimitRequests,
    required this.rateLimitInterval,
    required this.idempotencia,
    required this.jsonSchemaResp,
    required this.jsonSchemaReq,
    required this.pipelineVersaoId,
    required this.pipelineVersao,
    required this.criadoEm,
    required this.ultimaAlteracao,
  });

  factory Rotas.fromMap(Map<String, dynamic> map) {
    return Rotas(
      id: _int(map, 'id'),
      nome: _string(map, 'nome'),
      caminho: _string(map, 'caminho'),
      metodo: _metodo(map['metodo'] ?? map['Metodo']),
      descricao: _string(map, 'descricao'),
      senhaAcesso: _string(map, 'senhaAcesso'),
      usarFluxoMaisAtual: _bool(map, 'usarFluxoMaisAtual'),
      rateLimit: _bool(map, 'rateLimit'),
      rateLimitRequests: _int(map, 'rateLimitRequests'),
      rateLimitInterval: _int(map, 'rateLimitInterval'),
      idempotencia: _bool(map, 'idempotencia'),
      jsonSchemaResp: _string(map, 'jsonSchemaResp'),
      jsonSchemaReq: _string(map, 'jsonSchemaReq'),
      pipelineVersaoId: _int(map, 'pipelineVersaoId'),
      pipelineVersao: _string(map, 'pipelineVersao'),
      criadoEm: _string(map, 'criadoEm'),
      ultimaAlteracao: _string(map, 'ultimaAlteracao'),
    );
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

  static String _metodo(dynamic valor) {
    if (valor is int) {
      switch (valor) {
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
      }
    }

    return valor == null ? '' : valor.toString();
  }
}
