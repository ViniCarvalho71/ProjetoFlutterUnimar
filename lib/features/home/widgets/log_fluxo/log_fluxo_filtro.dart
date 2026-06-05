import 'package:flutter/material.dart';

import '../../models/log_fluxo_filtro_model.dart';

class LogFluxoFiltro extends StatefulWidget {
  final Function(LogFluxoFiltroModel filtro) onChanged;

  const LogFluxoFiltro({
    super.key,
    required this.onChanged,
  });

  @override
  State<LogFluxoFiltro> createState() => _LogFluxoFiltroState();
}

class _LogFluxoFiltroState extends State<LogFluxoFiltro> {
  final TextEditingController _pesquisaController =
      TextEditingController();

  DateTime? _dataInicial;
  DateTime? _dataFinal;

  void _notificarMudanca() {
    widget.onChanged(
      LogFluxoFiltroModel(
        pesquisa: _pesquisaController.text,
        dataInicial: _dataInicial,
        dataFinal: _dataFinal,
      ),
    );
  }

  Future<void> _selecionarDataInicial() async {
    final data = await showDatePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(
        const Duration(days: 365),
      ),
      initialDate: _dataInicial ?? DateTime.now(),
    );

    if (data != null) {
      setState(() {
        _dataInicial = data;
      });

      _notificarMudanca();
    }
  }

  Future<void> _selecionarDataFinal() async {
    final data = await showDatePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(
        const Duration(days: 365),
      ),
      initialDate: _dataFinal ?? DateTime.now(),
    );

    if (data != null) {
      setState(() {
        _dataFinal = data;
      });

      _notificarMudanca();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFFE0E7F2),
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x140B1F3A),
            blurRadius: 18,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          TextField(
            controller: _pesquisaController,
            onChanged: (_) => _notificarMudanca(),
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
              hintText: 'Pesquisar fluxo...',
              filled: true,
              fillColor: const Color(0xFFF7F9FC),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
            ),
          ),

          const SizedBox(height: 14),

          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _selecionarDataInicial,
                  icon: const Icon(Icons.calendar_month),
                  label: Text(
                    _dataInicial == null
                        ? 'Data inicial'
                        : '${_dataInicial!.day.toString().padLeft(2, '0')}/${_dataInicial!.month.toString().padLeft(2, '0')}/${_dataInicial!.year}',
                  ),
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _selecionarDataFinal,
                  icon: const Icon(Icons.calendar_month),
                  label: Text(
                    _dataFinal == null
                        ? 'Data final'
                        : '${_dataFinal!.day.toString().padLeft(2, '0')}/${_dataFinal!.month.toString().padLeft(2, '0')}/${_dataFinal!.year}',
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
              onPressed: () {
                setState(() {
                  _pesquisaController.clear();
                  _dataInicial = null;
                  _dataFinal = null;
                });

                _notificarMudanca();
              },
              icon: const Icon(Icons.clear),
              label: const Text('Limpar filtros'),
            ),
          ),
        ],
      ),
    );
  }
}