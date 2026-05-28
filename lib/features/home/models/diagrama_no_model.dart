import 'endpoint_model.dart';
import 'funcao_model.dart';
import 'no_model.dart';
import 'operacao_model.dart';

class DiagramaNoModel {
  final NoModel no;
  final OperacaoModel operacao;
  final EndpointModel? endpoint;
  final FuncaoModel? funcao;

  const DiagramaNoModel({
    required this.no,
    required this.operacao,
    this.endpoint,
    this.funcao,
  });

  String get titulo {
    if (endpoint != null && endpoint!.recurso.isNotEmpty) {
      return endpoint!.recurso;
    }
    if (funcao != null && funcao!.nome.isNotEmpty) {
      return funcao!.nome;
    }
    return no.descricaoCurta;
  }

  String get subtitulo {
    if (endpoint != null) {
      final integracao = endpoint!.integracao?.nome ?? '';
      if (integracao.isNotEmpty) {
        return integracao;
      }
      if (endpoint!.descricao.isNotEmpty) {
        return endpoint!.descricao;
      }
    }

    if (funcao != null) {
      final linhas = funcao!.totalLinhas;
      return linhas == 1 ? '1 linha de codigo' : '$linhas linhas de codigo';
    }

    if (no.tipo == 3 && no.chaveValor != null) {
      return 'Guarda dados';
    }

    if(no.tipo == 4) {
      return 'Pega dados salvos';
    }

    return 'No #${no.id}';
  }

  String get badge {
    if (endpoint != null) {
      return endpoint!.verboLabel;
    }
    if (funcao != null) {
      return 'JS';
    }
    if (no.tipo == 3) {
      return 'KEY';
    }
    if (no.tipo == 4) {
      return 'KEY';
    }
    return no.tipoLabel;
  }
}
