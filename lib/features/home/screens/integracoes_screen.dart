import 'package:flutter/material.dart';
import 'package:myapp/features/core/DI/injection.dart';
import 'package:myapp/features/core/widgets/app_drawer.dart';
import 'package:myapp/features/home/datasource/integracao/integracao_datasource.dart';

import '../models/integracao_model.dart';
import '../widgets/integracoes/barra_pesquisa.dart';
import '../widgets/integracoes/estado_integracoes_view.dart';
import '../widgets/integracoes/integracao_card.dart';
import '../widgets/integracoes/integracao_detail_sheet.dart';
import '../widgets/integracoes/total_integracoes_badge.dart';

class IntegracoesScreen extends StatefulWidget {
  const IntegracoesScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _IntegracoesScreenState();
  }
}

class _IntegracoesScreenState extends State<IntegracoesScreen> {
  final TextEditingController _pesquisaController = TextEditingController();

  String _pesquisa = '';
  List<IntegracaoModel> _integracoes = [];
  bool _carregando = false;
  String _erro = '';

  final IntegracaoDataSource _integracaoDataSource = getIt<IntegracaoDataSource>();

  @override
  void initState() {
    super.initState();
    _atualizarLista();
  }

  Future<void> _atualizarLista() async {
    setState(() {
      _carregando = true;
      _erro = '';
    });

    try {
      final integracoesApi = await _integracaoDataSource.getIntegracoes(
        pesquisa: _pesquisa,
      );

      if (!mounted) return;

      setState(() {
        _integracoes = integracoesApi;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _erro = e.toString();
        _integracoes = [];
      });
    } finally {
      if (mounted) {
        setState(() {
          _carregando = false;
        });
      }
    }
  }

  void _abrirDetalhes(IntegracaoModel integracao) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.82,
          minChildSize: 0.45,
          maxChildSize: 0.94,
          expand: false,
          builder: (context, scrollController) {
            return IntegracaoDetailSheet(
              integracao: integracao,
              scrollController: scrollController,
            );
          },
        );
      },
    );
  }

  Widget _montarConteudo() {
    return Column(
      children: [
        BarraPesquisa(
          controller: _pesquisaController,
          termoPesquisa: _pesquisa,
          onLimpar: () {
            _pesquisaController.clear();
            setState(() { _pesquisa = ''; });
            _atualizarLista();
          },
          onPesquisar: (valor) {
            setState(() {
              _pesquisa = valor.trim();
            });

            _atualizarLista();
          },
        ),
        Expanded(
          child: _montarListaOuEstado(),
        ),
      ],
    );
  }

  Widget _montarListaOuEstado() {
    if (_carregando) {
      return const EstadoIntegracoesView.carregando();
    }

    if (_erro.isNotEmpty) {
      return EstadoIntegracoesView(
        icone: Icons.cloud_off_outlined,
        titulo: 'Nao foi possivel carregar as integracoes',
        detalhe: _erro,
      );
    }

    if (_integracoes.isEmpty) {
      return const EstadoIntegracoesView(
        icone: Icons.extension_off_outlined,
        titulo: 'Nenhuma integracao encontrada',
      );
    }

    return ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 28),
      itemCount: _integracoes.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return TotalIntegracoesBadge(total: _integracoes.length);
        }

        final integracao = _integracoes[index - 1];

        return IntegracaoCard(
          integracao: integracao,
          onTap: () {
            _abrirDetalhes(integracao);
          },
        );
      },
    );
  }

  @override
  void dispose() {
    _pesquisaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FC),
      appBar: AppBar(
        title: const Text(
          'Integrações',
          style: TextStyle(fontWeight: FontWeight.w800, color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color(0xFF005BEA),
      ),
      drawer: const AppDrawer(paginaAtual: 'integrações'),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _atualizarLista,
          child: _montarConteudo(),
        ),
      ),
    );
  }
}
