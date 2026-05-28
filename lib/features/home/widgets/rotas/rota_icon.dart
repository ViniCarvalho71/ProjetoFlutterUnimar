import 'package:flutter/material.dart';

import 'rota_visual.dart';

class RotaIcon extends StatelessWidget {
  final RotaVisual visual;
  final double tamanho;
  final double tamanhoIcone;

  const RotaIcon({super.key,
    required this.visual,
    this.tamanho = 76,
    this.tamanhoIcone = 34
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: tamanho,
      height: tamanho,
      decoration: BoxDecoration(
        color: visual.cor.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20)),
      child: Icon(
        visual.icone,
        size: tamanhoIcone,
        color: visual.cor),
    );
  }
}
