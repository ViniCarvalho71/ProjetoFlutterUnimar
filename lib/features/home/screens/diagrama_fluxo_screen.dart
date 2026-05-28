import 'package:flutter/material.dart';

class DiagramaFluxoScreen extends StatelessWidget {
  const DiagramaFluxoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FC),
      appBar: AppBar(
        title: const Text(
          'Diagrama fluxo',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color(0xFF005BEA),
      ),
      body: const Center(
        child: Text('Aqui Mauricio'),
      ),
    );
  }
}
