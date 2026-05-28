import 'package:myapp/features/home/models/operacao_model.dart';

class FluxoPayloadModel {
  final List<OperacaoModel> operacoes;

  const FluxoPayloadModel({
    required this.operacoes,
  });

  factory FluxoPayloadModel.fromJson(Map<String, dynamic> json) {
    return FluxoPayloadModel(
      operacoes: (json['Operacoes'] as List)
          .map((item) => OperacaoModel.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Operacoes': operacoes.map((item) => item.toJson()).toList(),
    };
  }
}