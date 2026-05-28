import 'package:dio/dio.dart';
import 'package:myapp/features/core/errors/exceptions/conectasti_exception.dart';
import 'package:myapp/features/core/network/api_endpoints.dart';
import 'package:myapp/features/core/network/conectasti_api_client.dart';
import 'package:myapp/features/home/datasource/fluxo/fluxo_datasource.dart';
import 'package:myapp/features/home/models/diagrama_no_model.dart';
import 'package:myapp/features/home/models/endpoint_model.dart';
import 'package:myapp/features/home/models/fluxo_model.dart';
import 'package:myapp/features/home/models/funcao_model.dart';
import 'package:myapp/features/home/models/integracao_model.dart';
import 'package:myapp/features/home/models/no_model.dart';

class FluxoDatasourceImpl implements FluxoDatasource {
  final ConectaSTIApiClient apiClient;

  FluxoDatasourceImpl(this.apiClient);

  @override
  Future<FluxoModel> getFluxoById(int id) async {
    try {
      final response = await apiClient.dio.get(
        '${ApiEndpoints.fluxoVersionado}/$id',
      );
      if (response.statusCode != 200) {
        throw ConectastiException(
          'Erro ao buscar fluxo: ${response.statusCode}',
        );
      }
      return FluxoModel.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ConectastiException('Erro ao buscar fluxo: ${e.message}');
    }
  }

  @override
  Future<List<NoModel>> getNosByFluxoId(int fluxoId) async {
    try {
      FluxoModel fluxo = await getFluxoById(fluxoId);

      final operacoes = [...fluxo.payload.operacoes]
        ..sort((a, b) => a.ordem.compareTo(b.ordem));

      final noIds = operacoes.map((operacao) => operacao.noId).toSet().toList();

      final response = await apiClient.dio.get(
        ApiEndpoints.no,
        queryParameters: {'ids': noIds.join(',')},
      );

      final data = response.data;
      final items = data is List
          ? data
          : (data is Map && data['data'] is List
                ? data['data'] as List
                : const []);

      final nos = items
          .whereType<Map<String, dynamic>>()
          .map(NoModel.fromJson)
          .toList();

      final nosById = {for (final no in nos) no.id: no};

      return noIds.map((id) => nosById[id]).whereType<NoModel>().toList();
    } on DioException catch (e) {
      throw ConectastiException('Erro ao buscar nós do fluxo: ${e.message}');
    }
  }

  @override
  Future<List<DiagramaNoModel>> getDiagramaByFluxoId(int fluxoId) async {
    try {
      final fluxo = await getFluxoById(fluxoId);

      final operacoes = [...fluxo.payload.operacoes]
        ..sort((a, b) => a.ordem.compareTo(b.ordem));

      final noIds = operacoes.map((operacao) => operacao.noId).toSet().toList();
      final nos = await _getNosByIds(noIds);
      final nosById = {for (final no in nos) no.id: no};

      final detalhes = await Future.wait(
        operacoes.map((operacao) async {
          final no = nosById[operacao.noId];
          if (no == null) {
            return null;
          }

          final endpoint = no.endPointId == null
              ? null
              : await _getEndpointById(no.endPointId!);
          final funcao = no.funcaoId == null
              ? null
              : await _getFuncaoById(no.funcaoId!);

          return DiagramaNoModel(
            no: no,
            operacao: operacao,
            endpoint: endpoint,
            funcao: funcao,
          );
        }),
      );

      return detalhes.whereType<DiagramaNoModel>().toList();
    } on DioException catch (e) {
      throw ConectastiException(
        'Erro ao buscar diagrama do fluxo: ${e.message}',
      );
    }
  }

  Future<List<NoModel>> _getNosByIds(List<int> noIds) async {
    if (noIds.isEmpty) {
      return const [];
    }

    final response = await apiClient.dio.get(
      ApiEndpoints.no,
      queryParameters: {'ids': noIds.join(',')},
    );

    final items = _itemsFromResponse(response.data);

    return items
        .whereType<Map<String, dynamic>>()
        .map(NoModel.fromJson)
        .toList();
  }

  Future<EndpointModel?> _getEndpointById(int id) async {
    final data = await _getItemById(ApiEndpoints.endpoint, id);
    if (data == null) {
      return null;
    }

    final endpoint = EndpointModel.fromJson(data);
    if (endpoint.integracao != null || endpoint.integracaoId == 0) {
      return endpoint;
    }

    final integracao = await _getIntegracaoById(endpoint.integracaoId);
    return endpoint.copyWith(integracao: integracao);
  }

  Future<FuncaoModel?> _getFuncaoById(int id) async {
    final data = await _getItemById(ApiEndpoints.funcao, id);
    return data == null ? null : FuncaoModel.fromJson(data);
  }

  Future<IntegracaoModel?> _getIntegracaoById(int id) async {
    final data = await _getItemById(ApiEndpoints.integracao, id);
    return data == null ? null : IntegracaoModel.fromJson(data);
  }

  Future<Map<String, dynamic>?> _getItemById(String endpoint, int id) async {
    try {
      final response = await apiClient.dio.get('$endpoint/$id');
      final data = response.data;
      if (data is Map<String, dynamic>) {
        return data;
      }
      if (data is Map && data['data'] is Map<String, dynamic>) {
        return data['data'] as Map<String, dynamic>;
      }
      return null;
    } on DioException {
      return null;
    }
  }

  List<dynamic> _itemsFromResponse(dynamic data) {
    if (data is List) {
      return data;
    }
    if (data is Map && data['data'] is List) {
      return data['data'] as List;
    }
    return const [];
  }
}
