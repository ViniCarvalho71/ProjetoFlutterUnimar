class LogFluxoModel {
  final int fluxoId;
  final int versao;
  final int fluxoVersionadoId;
  final String nome;
  final DateTime? iniciadoEm;
  final DateTime? finalizadoEm;
  final int duracaoMs;
  final int quantidadeOperacoes;
  final int operacoesExecutadas;
  final int operacoesComSucesso;
  final int statusHttp;
  final bool sucesso;
  final int id;
  final DateTime? criadoEm;
  final DateTime? ultimaAlteracao;

  const LogFluxoModel({
    required this.fluxoId,
    required this.versao,
    required this.fluxoVersionadoId,
    required this.nome,
    required this.iniciadoEm,
    required this.finalizadoEm,
    required this.duracaoMs,
    required this.quantidadeOperacoes,
    required this.operacoesExecutadas,
    required this.operacoesComSucesso,
    required this.statusHttp,
    required this.sucesso,
    required this.id,
    required this.criadoEm,
    required this.ultimaAlteracao,
  });

  factory LogFluxoModel.fromJson(Map<String, dynamic> json) {
    return LogFluxoModel(
      fluxoId: json['fluxoId'] ?? 0,
      versao: json['versao'] ?? 0,
      fluxoVersionadoId: json['fluxoVersionadoId'] ?? 0,
      nome: json['nome'] ?? '',
      iniciadoEm: json['iniciadoEm'] != null
          ? DateTime.parse(json['iniciadoEm'])
          : null,
      finalizadoEm: json['finalizadoEm'] != null
          ? DateTime.parse(json['finalizadoEm'])
          : null,
      duracaoMs: json['duracaoMs'] ?? 0,
      quantidadeOperacoes: json['quantidadeOperacoes'] ?? 0,
      operacoesExecutadas: json['operacoesExecutadas'] ?? 0,
      operacoesComSucesso: json['operacoesComSucesso'] ?? 0,
      statusHttp: json['statusHttp'] ?? 0,
      sucesso: json['sucesso'] ?? false,
      id: json['id'] ?? 0,
      criadoEm: json['criadoEm'] != null
          ? DateTime.parse(json['criadoEm'])
          : null,
      ultimaAlteracao: json['ultimaAlteracao'] != null
          ? DateTime.parse(json['ultimaAlteracao'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fluxoId': fluxoId,
      'versao': versao,
      'fluxoVersionadoId': fluxoVersionadoId,
      'nome': nome,
      'iniciadoEm': iniciadoEm?.toIso8601String(),
      'finalizadoEm': finalizadoEm?.toIso8601String(),
      'duracaoMs': duracaoMs,
      'quantidadeOperacoes': quantidadeOperacoes,
      'operacoesExecutadas': operacoesExecutadas,
      'operacoesComSucesso': operacoesComSucesso,
      'statusHttp': statusHttp,
      'sucesso': sucesso,
      'id': id,
      'criadoEm': criadoEm?.toIso8601String(),
      'ultimaAlteracao': ultimaAlteracao?.toIso8601String(),
    };
  }
}