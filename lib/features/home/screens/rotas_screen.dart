import 'package:flutter/material.dart';
import 'package:myapp/features/core/DI/injection.dart';
import 'package:myapp/features/core/widgets/app_drawer.dart';
import 'package:myapp/features/home/datasource/rota/rota_datasource.dart';

import '../models/rotas.dart';
import '../widgets/rotas/barra_pesquisa.dart';
import '../widgets/rotas/estado_rotas_view.dart';
import '../widgets/rotas/rota_card.dart';
import '../widgets/rotas/rota_detail_sheet.dart';
import '../widgets/rotas/total_rotas_badge.dart';

class RotasScreen extends StatefulWidget {
  const RotasScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _RotasScreenState();
  }
}

class _RotasScreenState extends State<RotasScreen> {
  final TextEditingController _pesquisaController = TextEditingController();

  String _pesquisa = '';
  List<Rotas> _rotas = [];
  bool _carregando = false;
  String _erro = '';

  final RotaDataSource _rotaDataSource = getIt<RotaDataSource>();

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
      final rotasApi = await _rotaDataSource.getRotas(
        pesquisa: _pesquisa,
      );

      if (!mounted) return;

      setState(() {
        _rotas = rotasApi;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _erro = e.toString();
        _rotas = [];
      });
    } finally {
      if (mounted) {
        setState(() {
          _carregando = false;
        });
      }
    }
  }

  void _abrirDetalhes(Rotas rota) {
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
            return RotaDetailSheet(
              rota: rota,
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
      return const EstadoRotasView.carregando();
    }

    if (_erro.isNotEmpty) {
      return EstadoRotasView(
        icone: Icons.cloud_off_outlined,
        titulo: 'Nao foi possivel carregar as rotas',
        detalhe: _erro,
      );
    }

    if (_rotas.isEmpty) {
      return const EstadoRotasView(
        icone: Icons.route_outlined,
        titulo: 'Nenhuma rota encontrada',
      );
    }

    return ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 28),
      itemCount: _rotas.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return TotalRotasBadge(total: _rotas.length);
        }

        final rota = _rotas[index - 1];

        return RotaCard(
          rota: rota,
          onTap: () {
            _abrirDetalhes(rota);
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
          'Rotas',
          style: TextStyle(fontWeight: FontWeight.w800, color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color(0xFF005BEA),
      ),
      drawer: const AppDrawer(paginaAtual: 'rotas'),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _atualizarLista,
          child: _montarConteudo(),
        ),
      ),
    );
  }
}