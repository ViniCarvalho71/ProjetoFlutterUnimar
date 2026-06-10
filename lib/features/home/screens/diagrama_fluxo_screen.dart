import 'package:flutter/material.dart';
import 'package:myapp/features/core/DI/injection.dart';
import 'package:myapp/features/home/datasource/fluxo/fluxo_datasource.dart';
import 'package:myapp/features/home/models/diagrama_no_model.dart';
import 'package:myapp/features/home/widgets/diagrama_fluxo/diagrama_canvas.dart';
import 'package:myapp/features/home/widgets/diagrama_fluxo/diagrama_state_message.dart';

class DiagramaFluxoScreen extends StatefulWidget {
  final int fluxoId;
  final String? titulo;

  const DiagramaFluxoScreen({super.key, this.fluxoId = 1, this.titulo});

  @override
  State<StatefulWidget> createState() {
    return _DiagramaFluxoScreenState();
  }
}

class _DiagramaFluxoScreenState extends State<DiagramaFluxoScreen> {
  final FluxoDatasource _fluxoDatasource = getIt<FluxoDatasource>();
  late final Future<List<DiagramaNoModel>> _nosFuture;

  @override
  void initState() {
    super.initState();
    _nosFuture = _fluxoDatasource.getDiagramaByFluxoId(widget.fluxoId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FC),
      appBar: AppBar(
        title: Text(
          widget.titulo ?? 'Diagrama de Fluxo',
          style: const TextStyle(
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color(0xFF005BEA),
      ),
      body: SafeArea(
        child: DecoratedBox(
          decoration: const BoxDecoration(
            color: Color(0xFFF6F8FC),
            gradient: RadialGradient(
              center: Alignment.topLeft,
              radius: 1.1,
              colors: [Color(0xFFEAF2FF), Color(0xFFF6F8FC)],
            ),
          ),
          child: FutureBuilder<List<DiagramaNoModel>>(
            future: _nosFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Center(
                  child: DiagramaStateMessage(
                    icon: Icons.cloud_off_outlined,
                    title: 'Erro ao carregar diagrama',
                    detail: snapshot.error.toString(),
                  ),
                );
              }

              final nos = snapshot.data ?? const [];
              if (nos.isEmpty) {
                return const Center(
                  child: DiagramaStateMessage(
                    icon: Icons.account_tree_outlined,
                    title: 'Fluxo vazio',
                  ),
                );
              }

              return DiagramaCanvas(nos: nos);
            },
          ),
        ),
      ),
    );
  }
}
