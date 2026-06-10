import 'package:flutter/material.dart';

import 'integracao_visual.dart';

class IntegracaoIcon extends StatelessWidget {
  final IntegracaoVisual visual;
  final double tamanho;
  final double tamanhoIcone;

  const IntegracaoIcon({
    super.key,
    required this.visual,
    this.tamanho = 76,
    this.tamanhoIcone = 34,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: tamanho,
      height: tamanho,
      decoration: BoxDecoration(
        color: visual.cor.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Icon(visual.icone, size: tamanhoIcone, color: visual.cor),
    );
  }
}
