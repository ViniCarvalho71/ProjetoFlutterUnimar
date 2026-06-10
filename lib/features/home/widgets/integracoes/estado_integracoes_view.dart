import 'package:flutter/material.dart';

class EstadoIntegracoesView extends StatelessWidget {
  final IconData icone;
  final String titulo;
  final String? detalhe;

  const EstadoIntegracoesView({
    super.key,
    required this.icone,
    required this.titulo,
    this.detalhe,
  });

  const EstadoIntegracoesView.carregando({super.key})
      : icone = Icons.hourglass_empty,
        titulo = '',
        detalhe = null;

  @override
  Widget build(BuildContext context) {
    if (titulo.isEmpty) {
      return ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: const [
          SizedBox(
            height: 420,
            child: Center(child: CircularProgressIndicator()),
          ),
        ],
      );
    }

    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(24),
      children: [
        const SizedBox(height: 160),
        Icon(
          icone,
          size: 54,
          color: const Color(0xFF8FB8FF),
        ),
        const SizedBox(height: 16),
        Text(
          titulo,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        if (detalhe != null) ...[
          const SizedBox(height: 8),
          Text(
            detalhe!,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Color(0xFF667085)),
          ),
        ],
      ],
    );
  }
}
