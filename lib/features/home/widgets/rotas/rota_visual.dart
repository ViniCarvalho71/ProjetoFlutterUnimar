import 'package:flutter/material.dart';

import '../../models/rotas.dart';

class RotaVisual {
  final IconData icone;
  final Color cor;

  RotaVisual({ required this.icone, required this.cor });
}

RotaVisual visualDaRota(Rotas rota) { // uma classe para conseguir gerar uma imagem "aleatoria" nas rotas, foi a forma que achei para ficar bonitnho
  final chave = '${rota.id}|${rota.nome}|${rota.caminho}'; // Usa dados fixos da rota para que ela sempre receba o mesmo visual.
  final hash = chave.codeUnits.fold<int>(
    0,
    // Transforma o texto acima em um numero
    (anterior, atual) => (anterior * 31 + atual) & 0x7fffffff,
  );

  final icones = [
    Icons.location_on,
    Icons.alt_route,
    Icons.save,
    Icons.storage,
    Icons.account_tree,
    Icons.sync_alt,
    Icons.cloud_queue,
    Icons.hub,
  ];

  final cores = [
    const Color(0xFF0B63F6),
    const Color(0xFF2563EB),
    const Color(0xFF0891B2),
    const Color(0xFF16A34A),
    const Color(0xFFEA580C),
    const Color(0xFF7C3AED),
  ];

  return RotaVisual(
    // O resto da divisao (%) encaixa o hash dentro do tamanho das listas.
    icone: icones[hash % icones.length],
    cor: cores[hash % cores.length],
  );
}

String tituloRota(Rotas rota) {
  return rota.nome.isEmpty ? 'Rota ${rota.id}' : rota.nome;
}

String valorOuTraco(String valor) {
  return valor.trim().isEmpty ? '-' : valor;
}
