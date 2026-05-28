class OperacaoModel {
  final int ordem;
  final int noId;
  final bool repetir;
  final bool usarDadosAnterior;
  final int erro;
  final int maximoRepeticao;
  final int backoffType;
  final int backoffDelay;
  final double backoffMultiplier;
  final int timeout;

  const OperacaoModel({
    required this.ordem,
    required this.noId,
    required this.repetir,
    required this.usarDadosAnterior,
    required this.erro,
    required this.maximoRepeticao,
    required this.backoffType,
    required this.backoffDelay,
    required this.backoffMultiplier,
    required this.timeout,
  });

  factory OperacaoModel.fromJson(Map<String, dynamic> json) {
    return OperacaoModel(
      ordem: json['Ordem'] as int,
      noId: json['NoId'] as int,
      repetir: json['Repetir'] as bool,
      usarDadosAnterior: json['UsarDadosAnterior'] as bool,
      erro: json['Erro'] as int,
      maximoRepeticao: json['MaximoRepeticao'] as int,
      backoffType: json['BackoffType'] as int,
      backoffDelay: json['BackoffDelay'] as int,
      backoffMultiplier: (json['BackoffMultiplier'] as num).toDouble(),
      timeout: json['Timeout'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Ordem': ordem,
      'NoId': noId,
      'Repetir': repetir,
      'UsarDadosAnterior': usarDadosAnterior,
      'Erro': erro,
      'MaximoRepeticao': maximoRepeticao,
      'BackoffType': backoffType,
      'BackoffDelay': backoffDelay,
      'BackoffMultiplier': backoffMultiplier,
      'Timeout': timeout,
    };
  }
}