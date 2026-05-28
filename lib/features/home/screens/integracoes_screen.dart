import 'package:flutter/material.dart';

import '../../core/widgets/app_drawer.dart';

class IntegracoesScreen extends StatelessWidget {
  const IntegracoesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FC),
      appBar: AppBar(
        title: const Text(
          'Integracoes',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color(0xFF005BEA),
      ),
      drawer: const AppDrawer(paginaAtual: 'integracoes'),
      body: const Center(
        child: Text('aqui viniMiles'),)
    );
  }
}
