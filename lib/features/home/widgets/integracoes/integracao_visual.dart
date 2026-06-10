import 'package:flutter/material.dart';

import '../../models/integracao_model.dart';

class IntegracaoVisual {
  final IconData icone;
  final Color cor;

  IntegracaoVisual({ required this.icone, required this.cor });
}

IntegracaoVisual visualDaIntegracao(IntegracaoModel integracao) { // gera um visual "aleatorio" para a integracao, mesma ideia das rotas
  final chave = '${integracao.id}|${integracao.nome}|${integracao.url}'; // Usa dados fixos da integracao para que ela sempre receba o mesmo visual.
  final hash = chave.codeUnits.fold<int>(
    0,
    // Transforma o texto acima em um numero
    (anterior, atual) => (anterior * 31 + atual) & 0x7fffffff,
  );

  final icones = [
    Icons.extension,
    Icons.hub,
    Icons.cable,
    Icons.cloud_sync,
    Icons.api,
    Icons.link,
    Icons.share,
    Icons.settings_input_component,
  ];

  final cores = [
    const Color(0xFF0B63F6),
    const Color(0xFF2563EB),
    const Color(0xFF0891B2),
    const Color(0xFF16A34A),
    const Color(0xFFEA580C),
    const Color(0xFF7C3AED),
  ];

  return IntegracaoVisual(
    // O resto da divisao (%) encaixa o hash dentro do tamanho das listas.
    icone: icones[hash % icones.length],
    cor: cores[hash % cores.length],
  );
}

String tituloIntegracao(IntegracaoModel integracao) {
  return integracao.nome.isEmpty ? 'Integracao ${integracao.id}' : integracao.nome;
}

String valorOuTraco(String valor) {
  return valor.trim().isEmpty ? '-' : valor;
}
