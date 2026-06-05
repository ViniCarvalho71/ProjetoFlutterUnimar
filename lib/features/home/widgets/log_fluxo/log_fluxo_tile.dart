import 'package:flutter/material.dart';
import 'package:myapp/features/home/models/log_fluxo_model.dart';

class LogFluxoTile extends StatelessWidget {
  final LogFluxoModel logFluxo;
  final VoidCallback? onTap;

  const LogFluxoTile({
    super.key,
    required this.logFluxo,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final sucesso = logFluxo.sucesso;

    final corStatus = sucesso
        ? const Color(0xFF12B76A)
        : const Color(0xFFF04438);

    return Container(
      margin: const EdgeInsets.only(
        left: 12,
        right: 12,
        bottom: 14,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFFE0E7F2),
        ),
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
                    CircleAvatar(
                      radius: 26,
                      backgroundColor: corStatus.withOpacity(0.12),
                      child: Icon(
                        sucesso
                            ? Icons.check_circle
                            : Icons.error_outline,
                        color: corStatus,
                        size: 28,
                      ),
                    ),

                    const SizedBox(width: 16),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            logFluxo.nome,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                              height: 1.16,
                              color: Color(0xFF08111F),
                            ),
                          ),

                          const SizedBox(height: 10),

                          Wrap(
                            spacing: 10,
                            runSpacing: 6,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: corStatus.withOpacity(0.12),
                                  borderRadius:
                                      BorderRadius.circular(999),
                                ),
                                child: Text(
                                  sucesso ? 'Sucesso' : 'Erro',
                                  style: TextStyle(
                                    color: corStatus,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),

                              Text(
                                'HTTP ${logFluxo.statusHttp}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF344054),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
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

                const Divider(
                  height: 1,
                  color: Color(0xFFE3EAF5),
                ),

                const SizedBox(height: 14),

                Row(
                  children: [
                    const Icon(
                      Icons.account_tree,
                      size: 24,
                      color: Color(0xFF005BEA),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Fluxo ${logFluxo.fluxoId} • Versão ${logFluxo.versao}',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Color(0xFF475467),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                Row(
                  children: [
                    const Icon(
                      Icons.task_alt,
                      size: 24,
                      color: Color(0xFF005BEA),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Operações: ${logFluxo.operacoesComSucesso}/${logFluxo.quantidadeOperacoes}',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Color(0xFF475467),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                Row(
                  children: [
                    const Icon(
                      Icons.timer_outlined,
                      size: 24,
                      color: Color(0xFF005BEA),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Duração: ${logFluxo.duracaoMs} ms',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Color(0xFF475467),
                          fontWeight: FontWeight.w600,
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