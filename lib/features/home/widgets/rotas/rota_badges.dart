import 'package:flutter/material.dart';

class MetodoBadge extends StatelessWidget {
  final String metodo;

  const MetodoBadge({
    super.key,
    required this.metodo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration( color: const Color(0xFFDCEBFF), borderRadius: BorderRadius.circular(10)),
      child: Text(
        metodo.isEmpty ? '-' : metodo,
        style: const TextStyle(
          color: Color(0xFF005BEA),
          fontWeight: FontWeight.w800,
          fontSize: 15
        ),
      ),
    );
  }
}

class SimNaoBadge extends StatelessWidget {
  final bool valor;

  const SimNaoBadge({
    super.key,
    required this.valor,
  });

  @override
  Widget build(BuildContext context) {
    final cor = valor ? const Color(0xFF16A34A) : const Color(0xFF475467);
    final fundo = valor ? const Color(0xFFDFF8E8) : const Color(0xFFEDEFF3);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: fundo,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        valor ? 'Sim' : 'Nao',
        style: TextStyle(
          color: cor,
          fontWeight: FontWeight.w800,
          fontSize: 15,
        ),
      ),
    );
  }
}

class StatusAtivaBadge extends StatelessWidget {
  const StatusAtivaBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: const Color(0xFFDFF8E8),
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check_circle_outline, color: Color(0xFF16A34A), size: 18),
          SizedBox(width: 6),
          Text(
            'Ativa',
            style: TextStyle(
              color: Color(0xFF15803D),
              fontWeight: FontWeight.w800,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
