import 'package:flutter/material.dart';
import 'package:myapp/features/home/models/diagrama_no_model.dart';
import 'diagrama_visual.dart';

class DiagramaNodeModal extends StatelessWidget {
  final DiagramaNoModel diagramaNo;

  const DiagramaNodeModal({
    super.key,
    required this.diagramaNo,
  });
Widget _info(String titulo, String valor) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: Text(
            titulo,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
            ),
          ),
        ),

        Expanded(
          child: Text(valor),
        ),
      ],
    ),
  );
}
  @override
Widget build(BuildContext context) {
  final color = tipoNoColor(diagramaNo.no.tipo);

  return Dialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(24),
    ),
    child: Container(
      constraints: const BoxConstraints(
        maxWidth: 500,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [

          /// CABEÇALHO
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(24),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      tipoNoIcon(diagramaNo.no.tipo),
                      color: Colors.white,
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: Text(
                        diagramaNo.no.tipoLabel,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white24,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        diagramaNo.badge,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                Text(
                  diagramaNo.titulo,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),

          /// CONTEÚDO
          Flexible(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const Text(
                    'Informações Gerais',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  _info('ID do Nó', '${diagramaNo.no.id}'),

                  _info(
                    'Ordem',
                    '${diagramaNo.operacao.ordem}',
                  ),

                  _info(
                    'Timeout',
                    '${diagramaNo.operacao.timeout}s',
                  ),

                  _info(
                    'Repetir',
                    diagramaNo.operacao.repetir
                        ? 'Sim'
                        : 'Não',
                  ),

                  const SizedBox(height: 20),

                  if (diagramaNo.endpoint != null) ...[
                    const Divider(),

                    const SizedBox(height: 12),

                    const Text(
                      'Endpoint',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 12),

                    _info(
                      'Método',
                      diagramaNo.endpoint!.verboLabel,
                    ),

                    _info(
                      'Recurso',
                      diagramaNo.endpoint!.recurso,
                    ),

                    _info(
                      'Descrição',
                      diagramaNo.endpoint!.descricao,
                    ),
                  ],

                  if (diagramaNo.funcao != null) ...[
                    const Divider(),

                    const SizedBox(height: 12),

                    const Text(
                      'Função',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 12),

                    _info(
                      'Nome',
                      diagramaNo.funcao!.nome,
                    ),

                    const SizedBox(height: 12),

                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.black87,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: SelectableText(
                        diagramaNo.funcao!.corpoDaFuncao,
                        style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),

          /// BOTÃO
          Padding(
            padding: const EdgeInsets.all(16),
            child: Align(
              alignment: Alignment.centerRight,
              child: FilledButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Fechar'),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
}