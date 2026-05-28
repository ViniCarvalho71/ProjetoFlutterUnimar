import 'package:flutter/material.dart';

import '../../shared/widgets/app_drawer.dart';

class ExecucaoScreen extends StatelessWidget {
  const ExecucaoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FC),
      appBar: AppBar(
        title: const Text(
          'Execucao',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color(0xFF005BEA),
      ),
      drawer: const AppDrawer(paginaAtual: 'execucao'),
      body: const Center(
        child: Text('aqui vinicius'),
      ),
    );
  }
}
