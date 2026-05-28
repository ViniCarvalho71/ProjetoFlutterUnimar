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
      ordem: _int(json, 'ordem'),
      noId: _int(json, 'noId'),
      repetir: _bool(json, 'repetir'),
      usarDadosAnterior: _bool(json, 'usarDadosAnterior'),
      erro: _int(json, 'erro'),
      maximoRepeticao: _int(json, 'maximoRepeticao'),
      backoffType: _int(json, 'backoffType'),
      backoffDelay: _int(json, 'backoffDelay'),
      backoffMultiplier: _double(json, 'backoffMultiplier'),
      timeout: _int(json, 'timeout'),
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

  static double _double(Map<String, dynamic> map, String nome) {
    final valor = _valor(map, nome);
    if (valor is num) {
      return valor.toDouble();
    }
    return double.tryParse(valor?.toString() ?? '') ?? 0;
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
}
