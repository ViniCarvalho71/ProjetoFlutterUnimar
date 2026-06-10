import 'package:flutter/material.dart';

import '../../models/integracao_model.dart';
import '../../../core/services/date_service.dart';
import 'integracao_icon.dart';
import 'integracao_visual.dart';

class IntegracaoDetailSheet extends StatelessWidget {
  final IntegracaoModel integracao;
  final ScrollController scrollController;

  const IntegracaoDetailSheet({
    super.key,
    required this.integracao,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    final visual = visualDaIntegracao(integracao);

    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFF8FAFF),
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: ListView(
        controller: scrollController,
        padding: EdgeInsets.fromLTRB( 24, 12, 24,
        MediaQuery.of(context) // pega informação do dispositivo para ajustar o safe area
        .padding.bottom + 28),
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
              IntegracaoIcon(visual: visual, tamanho: 96, tamanhoIcone: 42),
              const SizedBox(width: 18),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tituloIntegracao(integracao),
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                        height: 1.12,
                        color: Color(0xFF08111F),
                      ),
                    ),
                    const SizedBox(height: 14),
                    const _StatusAtivaBadge(),
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
                icone: Icons.link,
                titulo: 'URL',
                valor: integracao.url,
              ),
              const _Divisor(),
              _LinhaInfo(
                icone: Icons.description_outlined,
                titulo: 'Descricao',
                valor: integracao.descricao,
              ),
            ],
          ),
          const SizedBox(height: 18),
          _BlocoDetalhe(
            titulo: 'Datas',
            iconeTitulo: Icons.calendar_today_outlined,
            children: [
              _LinhaInfo(
                icone: Icons.calendar_today,
                titulo: 'Criado em',
                valor: DateService.formatarDataHora(integracao.criadoEm),
                valorEmLinhaUnica: true,
              ),
              const _Divisor(),
              _LinhaInfo(
                icone: Icons.edit_outlined,
                titulo: 'Ultima alteracao',
                valor: DateService.formatarDataHora(integracao.ultimaAlteracao),
                valorEmLinhaUnica: true,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatusAtivaBadge extends StatelessWidget {
  const _StatusAtivaBadge();

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
  final bool valorEmLinhaUnica;

  const _LinhaInfo({
    required this.icone,
    required this.titulo,
    this.valor,
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
              child: _TextoValorInfo(
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
