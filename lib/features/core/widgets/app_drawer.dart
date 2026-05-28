import 'package:flutter/material.dart';

import '../../home/screens/execucao_screen.dart';
import '../../home/screens/rotas_screen.dart';
import '../../home/screens/integracoes_screen.dart';

class AppDrawer extends StatelessWidget {
  final String paginaAtual;

  const AppDrawer({
    super.key,
    required this.paginaAtual,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 292,
      backgroundColor: const Color(0xFFF7F9FD),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 28, 20, 18),
              child: Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: const Color(0xFF005BEA),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(
                      Icons.hub,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ConectaSTI',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF101828),
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Painel operacional',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF667085),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Divider(height: 1, color: Color(0xFFE1E7F0)),
            ),
            const SizedBox(height: 18),
            _DrawerItem(
              icone: Icons.route,
              titulo: 'Rotas',
              selecionado: paginaAtual == 'rotas',
              onTap: () {
                _navegar(context, 'rotas', RotasScreen());
              },
            ),
            _DrawerItem(
              icone: Icons.play_circle_outline,
              titulo: 'Execucao',
              selecionado: paginaAtual == 'execucao',
              onTap: () {
                _navegar(context, 'execucao', const ExecucaoScreen());
              },
            ),
            _DrawerItem(
              icone: Icons.hub_outlined,
              titulo: 'Integracoes',
              selecionado: paginaAtual == 'integracoes',
              onTap: () {
                _navegar(context, 'integracoes', const IntegracoesScreen());
              },
            ),
            const Spacer(),
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 22),
              child: Text(
                'ConectaSTI © 2026',
                style: TextStyle(
                  color: Color(0xFF98A2B3),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navegar(BuildContext context, String destino, Widget tela) {
    final navigator = Navigator.of(context);

    navigator.pop();

    if (paginaAtual == destino) {
      return;
    }

    navigator.pushReplacement(
      MaterialPageRoute(builder: (context) => tela),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final IconData icone;
  final String titulo;
  final bool selecionado;
  final VoidCallback onTap;

  const _DrawerItem({
    required this.icone,
    required this.titulo,
    required this.selecionado,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cor = selecionado ? const Color(0xFF005BEA) : const Color(0xFF344054);
    final fundo = selecionado ? const Color(0xFFEAF2FF) : Colors.transparent;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 3),
      child: Material(
        color: fundo,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: onTap,
          child: Container(
            height: 52,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Row(
              children: [
                Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    color: selecionado ? const Color(0xFFD7E8FF) : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: selecionado
                          ? const Color(0xFFBFD9FF)
                          : const Color(0xFFE4EAF2),
                    ),
                  ),
                  child: Icon(
                    icone,
                    color: cor,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    titulo,
                    style: TextStyle(
                      color: cor,
                      fontSize: 15,
                      fontWeight: selecionado ? FontWeight.w800 : FontWeight.w600,
                    ),
                  ),
                ),
                if (selecionado)
                  Container(
                    width: 6,
                    height: 24,
                    decoration: BoxDecoration(
                      color: const Color(0xFF005BEA),
                      borderRadius: BorderRadius.circular(99),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
