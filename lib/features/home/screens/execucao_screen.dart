import 'package:flutter/material.dart';
import 'package:myapp/features/core/DI/injection.dart';
import 'package:myapp/features/home/datasource/log_fluxo/log_fluxo_datasource.dart';
import 'package:myapp/features/home/models/log_fluxo_model.dart';
import 'package:myapp/features/home/widgets/diagrama_fluxo/diagrama_state_message.dart';
import 'package:myapp/features/home/widgets/log_fluxo/log_fluxo_listview.dart';

import '../../core/widgets/app_drawer.dart';

class ExecucaoScreen extends StatefulWidget {
  const ExecucaoScreen({super.key});

  @override
  State<ExecucaoScreen> createState() => _ExecucaoScreenState();
}

class _ExecucaoScreenState extends State<ExecucaoScreen> {
  final LogFluxoDatasource _datasource = getIt<LogFluxoDatasource>();

  late final Future<List<LogFluxoModel>> _logsFuture;

  @override
  void initState() {
    super.initState();
    _logsFuture = _datasource.getLogs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FC),
      appBar: AppBar(
        title: const Text(
          'Execução',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color(0xFF005BEA),
      ),
      drawer: const AppDrawer(
        paginaAtual: 'execucao',
      ),
      body: FutureBuilder<List<LogFluxoModel>>(
        future: _logsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: DiagramaStateMessage(
                icon: Icons.error_outline,
                title: 'Erro ao carregar execuções',
                detail: snapshot.error.toString(),
              ),
            );
          }

          final logs = snapshot.data ?? const [];

          if (logs.isEmpty) {
            return const Center(
              child: DiagramaStateMessage(
                icon: Icons.history_toggle_off,
                title: 'Nenhuma execução encontrada',
              ),
            );
          }

          return LogFluxoListView(
            logs: logs,
          );
        },
      ),
    );
  }
}
