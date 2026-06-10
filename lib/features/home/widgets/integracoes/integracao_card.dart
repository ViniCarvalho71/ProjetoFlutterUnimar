import 'package:flutter/material.dart';

import '../../models/integracao_model.dart';
import 'integracao_icon.dart';
import 'integracao_visual.dart';

class IntegracaoCard extends StatelessWidget {
  final IntegracaoModel integracao;
  final VoidCallback onTap;

  const IntegracaoCard({
    super.key,
    required this.integracao,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final visual = visualDaIntegracao(integracao);

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE0E7F2)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x140B1F3A),
            blurRadius: 18,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(18),
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IntegracaoIcon(visual: visual),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tituloIntegracao(integracao),
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                              height: 1.16,
                              color: Color(0xFF08111F),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            valorOuTraco(integracao.url),
                            style: const TextStyle(
                              fontSize: 16,
                              color: Color(0xFF344054),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(
                      Icons.chevron_right,
                      size: 32,
                      color: Color(0xFF172033),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Divider(height: 1, color: Color(0xFFE3EAF5)),
                const SizedBox(height: 14),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.description_outlined,
                      color: visual.cor,
                      size: 26,
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Text(
                        valorOuTraco(integracao.descricao),
                        style: const TextStyle(
                          fontSize: 16,
                          color: Color(0xFF475467),
                          fontWeight: FontWeight.w600,
                          height: 1.28,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
