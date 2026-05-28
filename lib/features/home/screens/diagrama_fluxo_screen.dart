import 'package:flutter/material.dart';
import 'package:myapp/features/core/DI/injection.dart';
import 'package:myapp/features/home/datasource/fluxo/fluxo_datasource.dart';

class DiagramaFluxoScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DiagramaFluxoScreenState();
  }
}

class _DiagramaFluxoScreenState extends State<DiagramaFluxoScreen> {

  final FluxoDatasource _fluxoDatasource = getIt<FluxoDatasource>();

  @override
  void initState() {
    super.initState();
    _fluxoDatasource.getNosByFluxoId(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Diagrama de Fluxo'),
      ),
      body: Center(
        child: Text('Aqui será exibido o diagrama de fluxo'),
      ),
    );
  }
}
