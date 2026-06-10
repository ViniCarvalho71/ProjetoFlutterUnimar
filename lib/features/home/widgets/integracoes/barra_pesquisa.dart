import 'package:flutter/material.dart';

class BarraPesquisa extends StatelessWidget {
  final TextEditingController controller;
  final String termoPesquisa;
  final VoidCallback onLimpar;
  final ValueChanged<String> onPesquisar;

  const BarraPesquisa({
    super.key,
    required this.controller,
    required this.termoPesquisa,
    required this.onLimpar,
    required this.onPesquisar,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: 'Pesquisar integracao pelo nome...',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: termoPesquisa.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: onLimpar,
                )
              : null,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
        ),
        onSubmitted: onPesquisar,
      ),
    );
  }
}
