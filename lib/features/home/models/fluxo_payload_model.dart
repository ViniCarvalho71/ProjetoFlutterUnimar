import 'package:myapp/features/home/models/operacao_model.dart';

class FluxoPayloadModel {
  final List<OperacaoModel> operacoes;

  const FluxoPayloadModel({required this.operacoes});

  factory FluxoPayloadModel.fromJson(Map<String, dynamic> json) {
    final operacoesJson = _list(json, 'operacoes');

    return FluxoPayloadModel(
      operacoes: operacoesJson
          .whereType<Map>()
          .map(
            (item) => OperacaoModel.fromJson(Map<String, dynamic>.from(item)),
          )
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'Operacoes': operacoes.map((item) => item.toJson()).toList()};
  }

  static dynamic _valor(Map<String, dynamic> map, String nome) {
    final pascal = nome.substring(0, 1).toUpperCase() + nome.substring(1);
    return map[nome] ?? map[pascal];
  }

  static List<dynamic> _list(Map<String, dynamic> map, String nome) {
    final valor = _valor(map, nome);
    if (valor is List) {
      return valor;
    }
    return const [];
  }
}
