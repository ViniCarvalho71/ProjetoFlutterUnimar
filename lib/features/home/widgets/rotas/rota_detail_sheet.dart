import 'package:flutter/material.dart';

import '../../screens/diagrama_fluxo_screen.dart';
import '../../models/rotas.dart';
import '../../../core/services/date_service.dart';
import 'rota_badges.dart';
import 'rota_icon.dart';
import 'rota_visual.dart';

class RotaDetailSheet extends StatelessWidget {
  final Rotas rota;
  final ScrollController scrollController;

  const RotaDetailSheet({
    super.key,
    required this.rota,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    final visual = visualDaRota(rota);

    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFF8FAFF),
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: ListView(
        controller: scrollController,
        padding: const EdgeInsets.fromLTRB(24, 12, 24, 28),
        children: [
          Center(
            child: Container(
              width: 52,
              height: 5,
              decoration: BoxDecoration(
                color: const Color(0xFFC6CEDA),
                borderRadius: BorderRadius.circular(99),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RotaIcon(visual: visual, tamanho: 96, tamanhoIcone: 42),
              const SizedBox(width: 18),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tituloRota(rota),
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                        height: 1.12,
                        color: Color(0xFF08111F),
                      ),
                    ),
                    const SizedBox(height: 14),
                    const StatusAtivaBadge(),
                  ],
                ),
              ),
              IconButton.filledTonal(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _BlocoDetalhe(
            children: [
              _LinhaInfo(
                icone: Icons.http,
                titulo: 'Metodo',
                valorWidget: MetodoBadge(metodo: rota.metodo),
              ),
              const _Divisor(),
              _LinhaInfo(
                icone: Icons.link,
                titulo: 'Endpoint',
                valor: rota.caminho,
              ),
              const _Divisor(),
              _LinhaInfo(
                icone: Icons.account_tree,
                titulo: 'Pipeline',
                valor: valorOuTraco(rota.pipelineVersao),
              ),
            ],
          ),
          const SizedBox(height: 18),
          _BlocoDetalhe(
            titulo: 'Configuracoes',
            iconeTitulo: Icons.settings_outlined,
            children: [
              _LinhaInfo(
                icone: Icons.sync_alt,
                titulo: 'Usar fluxo mais atual',
                valorWidget: SimNaoBadge(valor: rota.usarFluxoMaisAtual),
              ),
              const _Divisor(),
              _LinhaInfo(
                icone: Icons.shield_outlined,
                titulo: 'Rate limit',
                valorWidget: SimNaoBadge(valor: rota.rateLimit),
              ),
              const _Divisor(),
              _LinhaInfo(
                icone: Icons.tune,
                titulo: 'Rate limit requests',
                valor: rota.rateLimitRequests.toString(),
              ),
              const _Divisor(),
              _LinhaInfo(
                icone: Icons.schedule,
                titulo: 'Rate limit interval',
                valor: '${rota.rateLimitInterval} segundos',
              ),
              const _Divisor(),
              _LinhaInfo(
                icone: Icons.fingerprint,
                titulo: 'Idempotencia',
                valorWidget: SimNaoBadge(valor: rota.idempotencia),
              ),
              const _Divisor(),
              _LinhaInfo(
                icone: Icons.calendar_today,
                titulo: 'Criado em',
                valor: DateService.formatarDataHora(rota.criadoEm),
                valorEmLinhaUnica: true,
              ),
              const _Divisor(),
              _LinhaInfo(
                icone: Icons.edit_outlined,
                titulo: 'Ultima alteracao',
                valor: DateService.formatarDataHora(rota.ultimaAlteracao),
                valorEmLinhaUnica: true,
              ),
            ],
          ),
          const SizedBox(height: 18),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: () {
                final navigator = Navigator.of(context);

                navigator.pop();
                navigator.push(
                  MaterialPageRoute(
                    builder: (context) => DiagramaFluxoScreen(
                      fluxoId: rota.pipelineVersaoId,
                      titulo: tituloRota(rota),
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.account_tree_outlined),
              label: const Text('Ver diagrama'),
            ),
          ),
        ],
      ),
    );
  }
}

class _BlocoDetalhe extends StatelessWidget {
  final List<Widget> children;
  final String? titulo;
  final IconData? iconeTitulo;

  const _BlocoDetalhe({required this.children, this.titulo, this.iconeTitulo});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE0E7F2)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x100B1F3A),
            blurRadius: 16,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          if (titulo != null) ...[
            Row(
              children: [
                Icon(
                  iconeTitulo ?? Icons.info_outline,
                  color: const Color(0xFF0B63F6),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    titulo!,
                    style: const TextStyle(
                      color: Color(0xFF0B63F6),
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            const _Divisor(),
          ],
          ...children,
        ],
      ),
    );
  }
}

class _LinhaInfo extends StatelessWidget {
  final IconData icone;
  final String titulo;
  final String? valor;
  final Widget? valorWidget;
  final bool valorEmLinhaUnica;

  const _LinhaInfo({
    required this.icone,
    required this.titulo,
    this.valor,
    this.valorWidget,
    this.valorEmLinhaUnica = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icone, color: const Color(0xFF0B63F6), size: 24),
          const SizedBox(width: 14),
          Expanded(
            flex: 5,
            child: Text(
              titulo,
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFF344054),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Flexible(
            flex: 6,
            child: Align(
              alignment: Alignment.centerRight,
              child:
                  valorWidget ??
                  _TextoValorInfo(
                    valor: valorOuTraco(valor ?? ''),
                    linhaUnica: valorEmLinhaUnica,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TextoValorInfo extends StatelessWidget {
  final String valor;
  final bool linhaUnica;

  const _TextoValorInfo({required this.valor, required this.linhaUnica});

  @override
  Widget build(BuildContext context) {
    const estilo = TextStyle(
      fontSize: 16,
      color: Color(0xFF101828),
      fontWeight: FontWeight.w600,
      height: 1.25,
    );

    if (linhaUnica) {
      return FittedBox(
        fit: BoxFit.scaleDown,
        alignment: Alignment.centerRight,
        child: Text(
          valor,
          maxLines: 1,
          textAlign: TextAlign.right,
          style: estilo,
        ),
      );
    }

    return Text(valor, textAlign: TextAlign.right, style: estilo);
  }
}

class _Divisor extends StatelessWidget {
  const _Divisor();

  @override
  Widget build(BuildContext context) {
    return const Divider(height: 1, color: Color(0xFFE3EAF5));
  }
}
